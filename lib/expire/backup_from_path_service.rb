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
      basename = pathname.basename.to_s

      digits = basename.gsub(/[^0-9]/, '')

      year   = digits[0..3].to_i
      month  = digits[4..5].to_i
      day    = digits[6..7].to_i
      hour   = digits[8..9].to_i
      minute = digits[10..11].to_i

      DateTime.new(year, month, day, hour, minute)
    end
  end
end
