# frozen_string_literal: true

module Expire
  # Base class of all rules
  class RuleBase
    include Comparable

    def initialize(amount:)
      @amount = amount
    end

    attr_reader :amount

    def name
      match = self.class.to_s.match(/\A.*::(.+)Rule\z/) || return
      match[1].underscore
    end

    def <=>(other)
      rank <=> other.rank
    end
  end
end
