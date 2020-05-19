# frozen_string_literal: true

module Expire
  # Calculate expiration
  class CalculateService < CalculateServiceBase
    include Constants

    def initialize(args)
      super(args)
      @backups = BackupList.new(
        args[:backups].map { |backup| AuditedBackup.new(backup) }
      )
    end

    def call
      keep_two_latest
      keep_at_least
      keep_first_of_interval
      keep_first_of_interval_until
      keep_interval_from_now

      Result.new(backups)
    end

    def keep_at_least
      ammount = rules.at_least
      return unless ammount

      message = "keep at least #{ammount}"

      backups.latest(ammount).each do |backup|
        backup.add_reason_to_keep(message)
      end
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
      STEP_WIDTHS.each do |noun, adjective|
        KeepIntervalForService.call(
          adjective: adjective,
          backups:   backups,
          noun:      noun,
          rules:     rules
        )
      end
    end

    def keep_interval_from_now
      STEP_WIDTHS.each do |noun, adjective|
        KeepIntervalForFromNowService.call(
          adjective: adjective,
          backups:   backups,
          noun:      noun,
          now:       now,
          rules:     rules
        )
      end
    end

    def now
      @now ||= DateTime.now
    end
  end
end
