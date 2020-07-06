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

    FROM_NOW_ONE_PER_UNIT_FOR_RULE_NAMES = STEP_NOUNS.map do |unit|
      "from_now_one_per_#{unit}_for".to_sym
    end.freeze

    ALL_RULE_NAMES = [
      # 'at_least',
      :most_recent,
      ONE_PER_UNIT_RULE_NAMES,
      ONE_PER_UNIT_FOR_RULE_NAMES,
      FROM_NOW_ONE_PER_UNIT_FOR_RULE_NAMES
    ].flatten.freeze

    ALL_RULE_NAMES.each { |rule_name| attr_reader rule_name }

    class << self
      def from_string_values(raw_rules)
        raise_on_unknown_rule(raw_rules)

        rules = {}
        ONE_PER_UNIT_RULE_NAMES.each do |name|
          string = raw_rules[name]
          next unless string

          rules[name] = RuleBase.from_string(string)
        end

        new(rules)
      end

      private

      def raise_on_unknown_rule(raw_rules)
        raw_rules.each_key do |rule_name|
          raise UnknownRuleError.new(rule_name) \
            unless ALL_RULE_NAMES.include?(rule_name)
        end
      end
    end

    def initialize(rules = {})
      rules.each_key do |rule_name|
        raise UnknownRuleError.new(rule_name) \
          unless ALL_RULE_NAMES.include?(rule_name)
      end

      @rules = rules

      ALL_RULE_NAMES.each do |name|
        instance_variable_set("@#{name}", rules[name])
      end
    end

    attr_reader :rules

    def apply(backups)
      apply_most_recent_rule(backups)
      apply_one_per_unit_rules(backups)
      apply_one_per_unit_for_rules(backups)
      apply_from_now_one_per_unit_for_rules(backups)
    end

    private

    def apply_most_recent_rule(backups)
      rule = rules[:most_recent] || return
      rule.apply(backups)
    end

    def apply_one_per_unit_rules(backups)
      ONE_PER_UNIT_RULE_NAMES.each do |rule_name|
        rule = rules[rule_name]
        rule&.apply(backups)
      end
    end

    def apply_one_per_unit_for_rules(backups)
      ONE_PER_UNIT_FOR_RULE_NAMES.each do |rule_name|
        rule = rules[rule_name]
        rule&.apply(backups)
      end
    end

    def apply_from_now_one_per_unit_for_rules(backups)
      now = DateTime.now

      FROM_NOW_ONE_PER_UNIT_FOR_RULE_NAMES.each do |rule_name|
        rule = rules[rule_name]
        rule&.apply(backups, now)
      end
    end
  end
end
