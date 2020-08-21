# frozen_string_literal: true

module Expire
  # How backups are expired
  class Rules
    def self.from_yaml(file_name)
      pathname = Pathname.new(file_name)
      yaml_text = pathname.read
      yaml_rules = YAML.safe_load(yaml_text, symbolize_names: true)
      new(yaml_rules)
    end

    def self.rule_classes
      rule_classes = Expire.constants.select do |klass|
        Expire.const_get(klass).to_s =~ /Rule\z/
      end

      rules = rule_classes.map do |klass|
        "Expire::#{klass}".constantize.from_value('none')
      end

      rules.sort.map(&:class)
    end

    def self.rule_names
      rule_classes = Expire.constants.select do |klass|
        Expire.const_get(klass).to_s =~ /Rule\z/
      end

      rules = rule_classes.map do |klass|
        "Expire::#{klass}".constantize.from_value('none')
      end

      rules.sort.map(&:name)
    end

    def self.rule_option_names
      rule_classes = Expire.constants.select do |klass|
        Expire.const_get(klass).to_s =~ /Rule\z/
      end

      rules = rule_classes.map do |klass|
        "Expire::#{klass}".constantize.from_value('none')
      end

      rules.sort.map(&:option_name)
    end

    def initialize(given = {})
      @rules = given.map do |rule_name, value|
        rule_class = rule_class_for(rule_name)
        rule_class.from_value(value)
      end
    end

    attr_reader :rules

    def apply(backups, reference_datetime)
      rules.sort.each { |rule| rule.apply(backups, reference_datetime) }

      backups
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
