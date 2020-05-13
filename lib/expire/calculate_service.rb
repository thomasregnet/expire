# frozen_string_literal: true

module Expire
  # Calculate expiration
  class CalculateService
    include Constants

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
      # KeepFirstOfIntervalService.call(backups, rules)
      keep_first_of_interval

      Result.new(backups)
    end

    def keep_first_of_interval
      STEP_WIDTHS.each do |noun, adjective|
        KeepFirstOfIntervalService.call(
          adjective: adjective,
          backups:   backups,
          noun:      noun,
          rules:     rules
        )
      end
    end
  end
end
