# frozen_string_literal: true

module Expire
  # Keep first backups of a stepping
  class CalculateAdjectiveService < CalculateAdjectiveServiceBase
    # attr_reader :adjective, :backups, :noun, :rules
    attr_reader :adjective, :backups, :rules

    def call
      amount = rules.send adjective
      return if !amount || amount.zero?

      message = "keep #{amount} #{adjective}"

      mark_as_kept(one_per_reverse(noun).first(amount), message)
    end

    def one_per_reverse(noun)
      backups.one_per(noun).sort.reverse
    end

    private

    def mark_as_kept(kept_backups, message)
      kept_backups.each { |backup| backup.add_reason_to_keep(message) }
    end
  end
end
