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
      if path == '-'
        generate_backup_list_from($stdin)
      else
        pathname = Pathname.new(path)
        generate_backup_list_from(pathname.children)
      end
    end

    private

    def generate_backup_list_from(source)
      backup_list = BackupList.new

      source.each do |backup_path|
        backup_list << BackupFromPathService.call(path: backup_path)
      end

      backup_list
    end
  end
end
