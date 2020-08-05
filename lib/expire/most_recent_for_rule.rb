# frozen_string_literal: true

module Expire
  class MostRecentForRule < FromNowMostRecentForRule
    attr_reader :unit

    def apply(backups, _)
      reference_time = backups.newest
      super(backups, reference_time)
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
