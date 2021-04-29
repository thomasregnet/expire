# frozen_string_literal: true

module Expire
  # Take a path and return an instance of Expire::Backup
  class BackupFromPathService
    def self.call(path:)
      new(path: path).call
    end

    def initialize(path:)
      @pathname = Pathname.new(path)
    end

    attr_reader :by, :pathname

    def call
      Backup.new(time: time, pathname: pathname)
    end

    private

    def time
      digits = extract_digits

      year   = digits[0..3].to_i
      month  = digits[4..5].to_i
      day    = digits[6..7].to_i
      hour   = digits[8..9].to_i
      minute = digits[10..11].to_i

      time_for(year, month, day, hour, minute)
    end

    def time_for(year, month, day, hour, minute)
      Date.new(year, month, day)
      Time.new(year, month, day, hour, minute)
    rescue Date::Error
      raise InvalidPathError, "can't construct date and time from #{pathname}" 
    rescue ArgumentError
      raise InvalidPathError, "can't construct date and time from #{pathname}"
    end

    def extract_digits
      basename = pathname.basename.to_s

      digits = basename.gsub(/[^0-9]/, '')

      digits_length = digits.length

      return digits if digits_length == 12
      return digits if digits_length == 14

      raise InvalidPathError, "can't extract date and time from #{basename}"
    end
  end
end
