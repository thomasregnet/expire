# frozen_string_literal: true

module Expire
  # Calculate expiration
  class Calculate
    include Constants

    def initialize(backups, rules)
      @backups = backups.map { |backup| AuditedBackup.new(backup) }
      @rules   = rules
    end

    attr_reader :backups, :rules

    def call
      STEP_WIDTHS.each do |noun, adjective|
        rule = "#{adjective}_to_keep"
        ammount = rules.send rule
        next unless ammount || amount.zero?

        backups.one_per(noun)[0..amount].each do |backup|
          backup.add_reason_to_keep("keep #{amount} #{adjective}")
        end

        Result.new(backups)
      end
    end
  end
end
