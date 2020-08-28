# frozen_string_literal: true

module Expire
  # Keep the most recent backups for a
  # certain period of time.
  class MostRecentForRule < FromNowMostRecentForRule
    extend FromSpanValue
    include NumerusUnit

    attr_reader :unit

    def apply(backups, _)
      reference_datetime = backups.newest
      super(backups, reference_datetime)
    end

    def rank
      11
    end

    def reason_to_keep
      "keep most recent backups for #{amount} #{numerus_unit}"
    end
  end
end
