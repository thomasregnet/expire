# frozen_string_literal: true

module Expire
  # How backups are expired
  class Rules
    def self.from_options(options)
      known_rules = RuleList.name_symbols

      rule_options = options.select { |opt, _| known_rules.include?(opt) }

      new(rule_options)
    end

    def self.from_yaml(file_name)
      pathname = Pathname.new(file_name)
      yaml_text = pathname.read
      yaml_rules = YAML.safe_load(yaml_text, symbolize_names: true)
      new(yaml_rules)
    end

    def initialize(given = {})
      @rules = given.map do |rule_name, value|
        if value.respond_to? :rank
          value
        else
          rule_class = rule_class_for(rule_name)
          rule_class.from_value(value)
        end
      end
    end

    attr_reader :rules

    def apply(backups, reference_datetime)
      rules.sort.each { |rule| rule.apply(backups, reference_datetime) }

      backups
    end

    def merge(prior_rules)
      self.class.new(to_h.merge(prior_rules.to_h))
    end

    def to_h
      rules.map { |rule| [rule.name.to_sym, rule] }.to_h
    end

    private

    def rule_class_for(key)
      rule_class_name_for(key).constantize
    rescue NameError
      raise UnknownRuleError.new(key)
    end

    def rule_class_name_for(key)
      "::Expire::#{key.to_s.camelize}Rule"
    end
  end
end
