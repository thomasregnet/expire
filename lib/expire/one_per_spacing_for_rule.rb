# frozen_string_literal: true

module Expire
  # Hold backups for a period
  class OnePerSpacingForRule < SpacingRuleBase
    class << self
      def from_string(string, **args)
        stripped = string.strip.downcase

        # return new(amount: -1, spacing: 'year', unit: nil) if stripped == 'all'

        match = stripped.match %r{
          \A
          ([0-9_]+)
          [^0-9a-zA-Z]+
          (hour|day|week|month|year)s?
          \z
        }x

        raise ArgumentError, "#{string} is not a valid period" unless match

        args[:amount] = Integer(match[1])
        args[:unit]   = match[2]
        new(args)
      end
    end

    def initialize(unit:, **args)
      super(args)

      @unit = unit
    end

    attr_reader :unit
  end
end
