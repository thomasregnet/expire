# frozen_string_literal: true

require 'expire/unknown_rule_error'

module Expire
  # Rules how to expire backups
  class NewRules
    include Constants

    ONE_PER_UNIT_RULE_NAMES = STEP_NOUNS.map do |unit|
      "one_per_#{unit}".to_sym
    end.freeze

    ONE_PER_UNIT_FOR_RULE_NAMES = STEP_NOUNS.map do |unit|
      "one_per_#{unit}_for".to_sym
    end.freeze

    FROM_NOW_ONE_PER_UNIT_RULE_NAMES = STEP_NOUNS.map do |unit|
      "from_now_one_per_#{unit}".to_sym
    end.freeze

    FROM_NOW_ONE_PER_UNIT_FOR_RULE_NAMES = STEP_NOUNS.map do |unit|
      "from_now_one_per_#{unit}_for".to_sym
    end.freeze

    ALL_RULE_NAMES = [
      'at_least',
      ONE_PER_UNIT_RULE_NAMES,
      ONE_PER_UNIT_FOR_RULE_NAMES,
      FROM_NOW_ONE_PER_UNIT_RULE_NAMES,
      FROM_NOW_ONE_PER_UNIT_FOR_RULE_NAMES
    ].flatten.freeze

    ALL_RULE_NAMES.each { |rule_name| attr_reader rule_name }

    def initialize(rules = {})
      rules.each_key do |rule_name|
        raise UnknownRuleError.new(rule_name) \
          unless ALL_RULE_NAMES.include?(rule_name)
      end

      ONE_PER_UNIT_RULE_NAMES.each do |name|
        next unless rules.has_key?(name)
        rule = SimpleRule.new(amount: rules[name], name: name)
        instance_variable_set("@#{name}", rule)
      end
    end
  end
end
