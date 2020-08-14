# frozen_string_literal: true

module Expire
  class MostRecentForRule < FromNowMostRecentForRule
    extend FromSpanValue
    attr_reader :unit

    def apply(backups, _)
      reference_datetime = backups.newest
      super(backups, reference_datetime)
    end

    def rank
      11
    end

    def reason_to_keep
      numerus_unit = unit.pluralize(amount)
      "keep most recent backups for #{amount} #{numerus_unit}"
    end
  end
end
