# frozen_string_literal: true

module Expire
  # Keep the most recent Backups
  class KeepMostRecentRule < RuleBase
    using RefineAllAndNone

    RULE_RANK = 10

    def self.from_value(value)
      return new(amount: 0) if value.none?

      new(amount: Integer(value))
    end

    def self.rank
      RULE_RANK
    end

    def rank
      self.class.rank
    end

    def apply(backups, _)
      backups.most_recent(amount).each do |backup|
        backup.add_reason_to_keep(reason_to_keep)
      end
    end

    private

    def reason_to_keep
      return 'keep the most recent backup' if amount == 1

      "keep the #{amount} most recent backups"
    end
  end
end
