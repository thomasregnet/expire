# frozen_string_literal: true

module Expire
  # Keep first backups of a stepping
  class KeepFirstOfIntervalService
    include Constants

    def self.call(backups, rules)
      new(backups, rules).call
    end

    def initialize(backups, rules)
      @backups = backups.sort.reverse
      @rules = rules
    end

    attr_reader :backups, :rules

    def call
      STEP_WIDTHS.each do |noun, adjective|
        rule = "#{adjective}"
        amount = rules.send rule
        next if !amount || amount.zero?

        message = "keep #{amount} #{adjective}"

        mark_as_kept(one_per_reverse(noun).first(amount), message)
      end
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
