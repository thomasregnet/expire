# frozen_string_literal: true

module Expire
  # Keep one backup per year
  class YearlyRule < AdjectiveRule
    SECONDARY_RANK = 5

    def secondary_rank
      SECONDARY_RANK
    end
  end
end
