# frozen_string_literal: true

module Expire
  # Base class for rules with an adjective in their name
  class AdjectiveRule < Rule
    include Constants

    PRIMARY_RANK = 20
    SECONDARY_RANK_FOR = {
      'hourly' => 1,
      'daily' => 2,
      'weekly' => 3,
      'monthly' => 4,
      'yearly' => 5
    }.freeze

    def self.from_value(value)
    end

    def adjective
      match = class_name.downcase.match(/(hourly|daily|weekly|monthly|yearly)/)
      return unless match

      match[1]
    end

    def apply
    end

    def rank
      primary_rank + secondary_rank
    end

    def primary_rank
      PRIMARY_RANK
    end

    def secondary_rank
      SECONDARY_RANK_FOR[adjective]
    end

    def spacing
      NOUN_FOR[adjective]
    end

    private

    def class_name
      self.class.name
    end
  end
end
