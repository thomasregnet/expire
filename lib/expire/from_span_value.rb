# frozen_string_literal: true

module Expire
  # Provide a pseudo constructor for rules that require a span
  module FromSpanValue
    using RefineAllAndNone

    FROM_VALUE_REGEX = /
    \A
    (([0-9](_[0-9]+){0,})+)
    (\s+|\.)
    (hour|day|week|month|year)s?
    \z
    /x.freeze

    def from_value(string, **args)
      # return new(args.merge({ amount: 0, unit: nil })) if string.none?
      return new(**args.merge(amount: 0, unit: nil)) if string.none?

      stripped_down = string.strip.downcase
      match = stripped_down.match FROM_VALUE_REGEX
      raise ArgumentError, "#{string} is not a valid span value" unless match

      amount = Integer(match[1])
      unit = match[5]
      new(**args.merge(amount: amount, unit: unit))
    end
  end
end
