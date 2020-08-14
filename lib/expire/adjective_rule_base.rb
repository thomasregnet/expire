# frozen_string_literal: true

module Expire
  # Base class for rules with an adjective in their name
  class AdjectiveRuleBase < RuleBase
    include Constants
    using RefineAllAndNone

    PRIMARY_RANK = 20
    SECONDARY_RANK_FOR = {
      'hourly' => 1,
      'daily' => 2,
      'weekly' => 3,
      'monthly' => 4,
      'yearly' => 5
    }.freeze

    def self.from_value(value)
      value = -1 if value.all?
      value = 0 if value.none?

      integer_value = Integer(value)
      raise ArgumentError, 'must be at least -1' if integer_value < -1

      new(amount: integer_value)
    end

    def adjective
      @adjective ||= infer_adjective
    end

    def apply(backups, _)
      kept = backups.one_per(spacing).most_recent(amount)
      kept.each { |backup| backup.add_reason_to_keep(reason_to_keep) }
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

    def infer_adjective
      match = class_name.downcase.match(/(hourly|daily|weekly|monthly|yearly)/)
      return unless match

      match[1]
    end

    def reason_to_keep
      plural = 'backup'.pluralize(amount)
      "keep #{amount} #{adjective} #{plural}"
    end
  end
end
