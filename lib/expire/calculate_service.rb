# frozen_string_literal: true

module Expire
  # Calculate expiration
  class CalculateService < CalculateServiceBase
    include Constants

    def initialize(args)
      super(args)
      @backups = backups.to_audited_backup_list
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
      STEP_ADJECTIVES.each do |adjective|
        CalculateAdjectiveService.call(
          adjective: adjective,
          backups:   backups,
          rules:     rules
        )
      end
    end

    def keep_first_of_interval_until
      STEP_ADJECTIVES.each do |adjective|
        CalculateAdjectiveForService.call(
          adjective: adjective,
          backups:   backups,
          rules:     rules
        )
      end
    end

    def keep_interval_from_now
      STEP_ADJECTIVES.each do |adjective|
        CalculateAdjectiveForFromNowService.call(
          adjective: adjective,
          backups:   backups,
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
