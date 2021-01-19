# frozen_string_literal: true

module Expire
  # Take a path and return an instance of Expire::Backup
  class BackupFromPathService
    def self.call(path:, by: :path)
      new(path: path, by: by).call
    end

    def initialize(path:, by: :path)
      @by       = by
      @pathname = Pathname.new(path)

      raise ArgumentError, "by: must be :ctime, :mtime or :path, not #{by}" unless %i[ctime mtime path].include?(by)
    end

    attr_reader :by, :pathname

    def call
      Backup.new(datetime: datetime, path: pathname)
    end

    private

    def datetime
      digits = extract_digits

      year   = digits[0..3].to_i
      month  = digits[4..5].to_i
      day    = digits[6..7].to_i
      hour   = digits[8..9].to_i
      minute = digits[10..11].to_i

      # DateTime.new(year, month, day, hour, minute)
      datetime_for(year, month, day, hour, minute)
    end

    def datetime_for(year, month, day, hour, minute)
      DateTime.new(year, month, day, hour, minute)
    rescue Date::Error
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
