# frozen_string_literal: true

module Expire
  # List rule classes, names and option-names
  class RuleList
    include Singleton

    def self.class_names
      instance.class_names
    end

    def self.names
      instance.names
    end

    def self.name_symbols
      instance.name_symbols
    end

    def self.option_names
      instance.option_names
    end

    def class_names
      @class_names ||= rule_classes.map(&:to_s).freeze
    end

    def names
      rule_classes.map(&:name)
    end

    def name_symbols
      names.map(&:to_sym)
    end

    def option_names
      rule_classes.map(&:option_name)
    end

    private

    def rule_classes
      @rule_classes ||= rule_class_names.map(&:constantize).sort.freeze
    end

    def rule_class_names
      class_symbols = Expire.constants.select { |klass| Expire.const_get(klass).to_s.end_with?("Rule") }

      class_symbols.map { |c_sym| "Expire::#{c_sym}" }
    end
  end
end
