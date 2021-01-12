# frozen_string_literal: true

module Expire
  # Reads contents of a directory and returns a corresponding BackupList
  class FromDirectoryService
    def self.call(path)
      new(path).call
    end

    def initialize(path)
      @pathname = Pathname.new(path)
    end

    attr_reader :pathname

    def call
      backups = BackupList.new

      pathname.children.each do |backup_dir|
        backups << BackupFromPathService.call(path: backup_dir)
      end

      backups
    end
  end
end
