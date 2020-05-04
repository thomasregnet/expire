require 'byebug'

module Expire
  # All Backups go here
  class BackupList
    def initialize(backups = [])
      @backups = backups
    end

    attr_reader :backups

    def one_per(interval)
      return [] unless backups.any?

      result = [backups.sort.first]
      message = "same_#{interval}?"

      backups.sort.each do |backup|
        result << backup unless backup.send(message, result.last)
      end

      result
    end
  end
end
