# frozen_string_literal: true

module Expire
  # Keep one backup per day
  class DailyRule < AdjectiveRule
    SECONDARY_RANK = 2

    def  secondary_rank
      SECONDARY_RANK
    end
  end
end
