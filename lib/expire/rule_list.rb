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

      instances = class_symbols.map do |c_sym|
        "Expire::#{c_sym}".constantize.from_value('none')
      end

      @rule_instances = instances.sort
    end

    def class_names
      rule_instances.map { |instance| instance.class.to_s }
    end

    def names
      rule_instances.map(&:name)
    end

    def name_symbols
      names.map(&:to_sym)
    end

    def option_names
      rule_instances.map(&:option_name)
    end

    private

    attr_reader :rule_instances
  end
end
