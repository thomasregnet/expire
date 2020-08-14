# frozen_string_literal: true

module Expire
  class FromNowMostRecentForRule < RuleBase
    extend FromSpanValue

    def initialize(unit:, **args)
      super(args)

      @unit = unit
    end

    attr_reader :unit

    def apply(backups, datetime_now)
      reference_datetime = datetime_now - amount.send(unit)
      kept = backups.not_older_than(reference_datetime)

      kept.each do |backup|
        backup.add_reason_to_keep(reason_to_keep)
      end
    end

    def rank
      12
    end

    def reason_to_keep
      numerus_unit = unit.pluralize(amount)

      "from now keep most recent backups for #{amount} #{numerus_unit}"
    end
  end
end
