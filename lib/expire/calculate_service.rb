# frozen_string_literal: true

module Expire
  # Calculate expiration
  class CalculateService
    include Constants

    def self.call(*args)
      new(*args).call
    end

    def initialize(backups:, rules:)
      @backups = BackupList.new(
        backups.map { |backup| AuditedBackup.new(backup) }
      )
      @rules = rules
    end

    attr_reader :backups, :rules

    def call
      keep_two_latest
      keep_first_of_interval
      keep_first_of_interval_until

      Result.new(backups)
    end

    def keep_two_latest
      backups.latest(2).each do |backup|
        backup.add_reason_to_keep('keep the two latest')
      end
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

    def keep_first_of_interval_until
      now = backups.min

      STEP_WIDTHS.each do |noun, adjective|
        KeepFirstOfIntervalUntilService.call(
          adjective: adjective,
          backups:   backups,
          noun:      noun,
          now:       now,
          rules:     rules
        )
      end
    end
  end
end
