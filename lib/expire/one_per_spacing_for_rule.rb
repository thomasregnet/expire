# frozen_string_literal: true

module Expire
  # Hold backups for a period
  class OnePerSpacingForRule < SpacingRuleBase
    FROM_STRING_REGEX = /
    \A
    ([0-9_]+)
    [^0-9a-zA-Z]+
    (hour|day|week|month|year)s?
    \z
    /x.freeze

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
  end
end
