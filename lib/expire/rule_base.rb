# frozen_string_literal: true

module Expire
  # Base class of all rules
  class RuleBase
    def initialize(amount:)
      @amount = amount
    end

    attr_reader :amount
  end
end
