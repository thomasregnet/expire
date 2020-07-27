# frozen_string_literal: true

module Expire
  # Base class of all rules
  class Rule
    def initialize(amount:)
      @amount = amount
    end

    attr_reader :amount
  end
end
