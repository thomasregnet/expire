# frozen_string_literal: true

module Expire
  # List rule classes, names and option-names
  class RuleList
    def self.class_names
      new.class_names
    end

    def self.names
      new.names
    end

    def self.option_names
      new.option_names
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

    def option_names
      rule_instances.map(&:option_name)
    end

    private

    attr_reader :rule_instances
  end
end
