# frozen_string_literal: true

module Expire
  # Calculate expiration until
  class KeepIntervalForService < KeepServiceBase
    def call
      deadline = calculate_deadline || return

      message = "keep all #{adjective} until #{deadline}"

      backups.one_per(noun).each do |backup|
        backup.add_reason_to_keep(message) if backup >= deadline
      end
    end

    def calculate_amount
      rules.send rule
    end

    def calculate_deadline
      amount = calculate_amount || return
      return unless amount

      num, duration = amount.split(/[^a-zA-Z0-9]/)
      now - num.to_i.send(duration)
    end

    def now
      @now ||= backups.max
    end

    def rule
      "#{adjective}_for"
    end
  end
end