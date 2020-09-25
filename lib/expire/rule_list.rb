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

    def initialize
      class_symbols = Expire.constants.select do |klass|
        Expire.const_get(klass).to_s =~ /Rule\z/
      end

      rule_class_names = class_symbols.map { |c_sym| "Expire::#{c_sym}" }
      @rule_classes = rule_class_names.map(&:constantize).sort.freeze
      @class_names = rule_classes.map(&:to_s).freeze
    end

    attr_reader :class_names, :rule_classes

    def names
      rule_classes.map(&:name)
    end

    def name_symbols
      names.map(&:to_sym)
    end

    def option_names
      rule_classes.map(&:option_name)
    end
  end
end
