# frozen_string_literal: true

module Expire
  # Keep the most recent backups from now for a certain
  # period of time.
  class FromNowMostRecentForRule < RuleBase
    extend FromSpanValue
    include NumerusUnit

    RULE_RANK = 12

    def self.rank
      RULE_RANK
    end

    def initialize(unit:, **args)
      super(**args)

      @unit = unit
    end

    attr_reader :unit

    def apply(backups, datetime_now)
      reference_datetime = datetime_now - amount.send(unit)
      kept = backups.not_older_than(reference_datetime)

      kept.each do |backup|
        backup.add_reason_to_keep(reason_to_keep)
      end
    end

    def rank
      self.class.rank
    end

    def reason_to_keep
      "from now keep most recent backups for #{amount} #{numerus_unit}"
    end
  end
end
