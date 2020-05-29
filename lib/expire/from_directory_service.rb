# frozen_string_literal: true

module Expire
  # Reads contents of a directory and returns a corresponding BackupList
  class FromDirectoryService
    def self.call(path)
      BackupList.new
    end
  end
end
