# frozen_string_literal: true

module Expire
  # Keep the most recent backups for a
  # certain period of time.
  class KeepMostRecentForRule < FromNowKeepMostRecentForRule
    extend FromSpanValue
    include NumerusUnit

    RULE_RANK = 11

    attr_reader :unit

    def self.rank
      RULE_RANK
    end

    def apply(backups, _)
      reference_datetime = backups.newest
      super(backups, reference_datetime)
    end

    def rank
      self.class.rank
    end

    def reason_to_keep
      "keep most recent backups for #{amount} #{numerus_unit}"
    end
  end
end
