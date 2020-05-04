module Expire
  # All Backups go here
  class BackupList
    def initialize(backups = [])
      @backups = backups
    end

    attr_reader :backups

    def one_per(interval)
      return [] unless backups.any?

      result = [backups.first]
      message = "same_#{interval}?"

      backups.sort.reverse.each do |backup|
        next if backup.send message, result.last
        result << backup
      end

      result
    end
  end
end
