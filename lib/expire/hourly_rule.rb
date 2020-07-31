# frozen_string_literal: true

module Expire
  # Keep one backup per hour
  class HourlyRule < AdjectiveRule
    SECONDARY_RANK = 1

    def secondary_rank
      SECONDARY_RANK
    end
  end
end
