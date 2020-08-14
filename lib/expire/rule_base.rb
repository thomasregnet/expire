# frozen_string_literal: true

module Expire
  # Base class of all rules
  class RuleBase
    include Comparable

    def initialize(amount:)
      @amount = amount
    end

    attr_reader :amount

    def <=>(other)
      rank <=> other.rank
    end
  end
end
