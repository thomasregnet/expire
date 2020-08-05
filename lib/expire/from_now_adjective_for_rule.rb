# frozen_string_literal: true

module Expire
  # Base class for from-now rules
  class FromNowAdjectiveForRule < AdjectiveRule
    PRIMARY_RANK = 40

    def initialize(unit:, **args)
      super(args)

      @unit = unit
    end

    attr_reader :unit

    def apply(backups, reference_datetime)
      minimal_datetime = reference_datetime - amount.send(unit)
      kept = backups.one_per(spacing).not_older_than(minimal_datetime)

      kept.each { |backup| backup.add_reason_to_keep(reason_to_keep) }
    end

    def primary_rank
      PRIMARY_RANK
    end

    def reason_to_keep
      numerus_unit = unit.pluralize(amount)
      "from now keep all backups for #{amount} #{numerus_unit}"
    end
  end
end
