# frozen_string_literal: true

module Expire
  # Calculate expiration
  class Calculate
    def self.call(backups, rules)
      new(backups, rules).call
    end

    def initialize(backups, rules)
      @backups = BackupList.new(
        backups.map { |backup| AuditedBackup.new(backup) }
      )
      @rules = rules
    end

    attr_reader :backups, :rules

    def call
      KeepFirstOfIntervalService.call(backups, rules)

      Result.new(backups)
    end
  end
end
