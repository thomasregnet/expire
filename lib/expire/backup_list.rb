module Expire
  # All Backups go here
  class BackupList
    def initialize(backups = [])
      @backups = backups
    end

    attr_reader :backups
  end
end
