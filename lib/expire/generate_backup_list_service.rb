# frozen_string_literal: true

module Expire
  # Reads contents of a directory and returns a corresponding BackupList
  class GenerateBackupListService
    def self.call(path)
      new(path).call
    end

    def initialize(path)
      @path = path
    end

    attr_reader :path

    def call
      path == '-' ? from_stdin : from_directory
    end

    private

    def from_directory
      backup_list = BackupList.new
      pathname = Pathname.new(path)

      pathname.children.each do |backup_path|
        backup_list << BackupFromPathService.call(path: backup_path)
      end

      backup_list
    end

    def from_stdin
      backup_list = BackupList.new

      $stdin.each do |backup_path|
        backup_list << BackupFromPathService.call(path: backup_path)
      end

      backup_list
    end
  end
end
