# frozen_string_literal: true

module Expire
  # Keep one backup per month
  class MonthlyRule < AdjectiveRule
    SECONDARY_RANK = 4

    def secondary_rank
      SECONDARY_RANK
    end
  end
end
