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
      STEP_WIDTHS.each do |noun, adjective|
        rule = "#{adjective}_to_keep"
        amount = rules.send rule
        next if !amount || amount.zero?

        backups.one_per(noun).first(amount).each do |backup|
          backup.add_reason_to_keep("keep #{amount} #{adjective}")
        end
      end

      Result.new(backups)
    end
  end
end
