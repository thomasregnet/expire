# frozen_string_literal: true

module Expire
  # Calculate expiration
  class Calculate
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
      calculate_first_to_keep

      Result.new(backups)
    end

    def calculate_first_to_keep
      STEP_WIDTHS.each do |noun, adjective|
        rule = "#{adjective}_to_keep"
        amount = rules.send rule
        next if !amount || amount.zero?

        message = "keep #{amount} #{adjective}"

        mark_as_kept(backups.one_per(noun).first(amount), message)
      end
    end

    private

    def mark_as_kept(kept_backups, message)
      kept_backups.each { |backup| backup.add_reason_to_keep(message) }
    end
  end
end
