# frozen_string_literal: true

module Expire
  # Hold backups for a period
  class AdjectiveForRule < FromNowAdjectiveForRule
    include Constants

    FROM_STRING_REGEX = /
    \A
    ([0-9_]+)
    [^0-9a-zA-Z]+
    (hour|day|week|month|year)s?
    \z
    /x.freeze

    PRIMARY_RANK = 30

    def self.from_string(string, **args)
      stripped = string.strip.downcase
      match = stripped.match FROM_STRING_REGEX
      raise ArgumentError, "#{string} is not a valid period" unless match

      amount = Integer(match[1])
      unit = match[2]
      new(args.merge({ amount: amount, unit: unit }))
    end

    def initialize(unit:, **args)
      super(args)

      @unit = unit
    end

    attr_reader :unit

    def apply(backups, _)
      super(backups, backups.newest)
    end

    def primary_rank
      PRIMARY_RANK
    end

    def reason_to_keep
      backup_form = 'backup'.pluralize(amount)
      "keep #{amount} #{ADJECTIVE_FOR[spacing]} #{backup_form}"
    end
  end
end
