# frozen_string_literal: true

module Expire
  # Base class for from-now rules
  class FromNowKeepAdjectiveForRuleBase < KeepAdjectiveRuleBase
    extend FromRangeValue
    include NumerusUnit

    PRIMARY_RANK = 40

    def self.primary_rank
      PRIMARY_RANK
    end

    def initialize(unit:, **args)
      super(**args)

      @unit = unit
    end

    attr_reader :unit

    def apply(backups, reference_time)
      minimal_time = reference_time - amount.send(unit)
      kept = backups.one_per(spacing).not_older_than(minimal_time)

      kept.each { |backup| backup.add_reason_to_keep(reason_to_keep) }
    end

    def primary_rank
      self.class.primary_rank
    end

    def reason_to_keep
      "from now keep all backups for #{amount} #{numerus_unit}"
    end
  end
end
