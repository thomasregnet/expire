# frozen_string_literal: true

module Expire
  # Thrown if a rule-name is not known
  class UnknownRuleError < StandardError
    def initialize(rule_name)
      super("unknown rule name \"#{rule_name}\"")
    end
  end
end
