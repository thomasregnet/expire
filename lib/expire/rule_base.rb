# frozen_string_literal: true

module Expire
  # Base class of all rules
  class RuleBase
    include Comparable

    def initialize(amount:)
      @amount = amount
    end

    attr_reader :amount

    def name
      match = self.class.to_s.match(/\A.*::(.+)Rule\z/) || return
      match[1].underscore
    end

    def numerus_backup
      'backup'.pluralize(amount)
    end

    def option_name
      camelized = camelized_name || return
      "--#{camelized.underscore.dasherize}"
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
