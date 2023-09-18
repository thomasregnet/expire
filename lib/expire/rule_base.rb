# frozen_string_literal: true

module Expire
  # Base class of all rules
  class RuleBase
    include Comparable

    def self.<=>(other)
      rank <=> other.rank
    end

    def self.camelized_name
      match = to_s.match(/\A.*::(.+)Rule\z/) || return
      match[1]
    end

    def self.name
      camelized_name&.underscore
    end

    def self.option_name
      rule_name = name || return
      "--#{rule_name.dasherize}"
    end

    def initialize(amount:)
      @amount = amount
    end

    attr_reader :amount

    def name
      camelized_name&.underscore
    end

    def numerus_backup
      "backup".pluralize(amount)
    end

    def option_name
      rule_name = name || return
      "--#{rule_name.dasherize}"
    end

    def <=>(other)
      rank <=> other.rank
    end

    private

    def camelized_name
      match = self.class.to_s.match(/\A.*::(.+)Rule\z/) || return
      match[1]
    end
  end
end
