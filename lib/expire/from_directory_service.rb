# frozen_string_literal: true

module Expire
  # Reads contents of a directory and returns a corresponding BackupList
  class FromDirectoryService
    def self.call(path)
      new(path).call
    end

    def initialize(path)
      @path = Pathname.new(path)
    end

    attr_reader :path

    def call
      backups = BackupList.new

      path.children.each do |backup_dir|
        backups << BackupFromPathService.call(path: backup_dir)
      end

      backups
    end
  end
end
