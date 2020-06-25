# frozen_string_literal: true

module Expire
  # A rule with a spacing
  class SpacingRule < RuleBase
    VALID_SPACINGS = %w[hour hours day days week weeks month months year years]

    def initialize(spacing:, **args)
      super(args)
      raise ArgumentError, "#{spacing} is not a valid spacing" \
        unless VALID_SPACINGS.include?(spacing)

      @spacing = spacing
    end

    attr_reader :spacing
  end
end
