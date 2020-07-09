# frozen_string_literal: true

module Expire
  # Reads contents of a directory and returns a corresponding BackupList
  class FromDirectoryService
    def self.call(path)
      new(path).call
    end

    def initialize(path)
      @path = Pathname.new(path)

      # @backup_list = BackupList.new
      @backups = Backups.new
    end

    attr_reader :backups, :path

    def call
      # raise "#{Dir.pwd[30..42]}"
      path.children.each do |backup_dir|
        datetime = datetime_for(backup_dir)

        backup = Backup.new(datetime: datetime, path: backup_dir)
        backups << backup
      end

      backups
    end

    private

    def datetime_for(backup_dir)
      basename = backup_dir.basename.to_s

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
