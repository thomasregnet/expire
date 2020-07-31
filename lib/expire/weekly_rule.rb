# frozen_string_literal: true

module Expire
  # Keep one backup per week
  class WeeklyRule < AdjectiveRule
    SECONDARY_RANK = 3

    def secondary_rank
      SECONDARY_RANK
    end
  end
end
