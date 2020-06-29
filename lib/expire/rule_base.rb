# frozen_string_literal: true

module Expire
  # A simple expire rule consists of the amount of backups to keep an a name
  class RuleBase
    class << self
      def from_string(string)
        stripped = string.strip.downcase

        amount = case stripped
                 when 'all' then -1
                 when 'none' then 0
                 else
                   amount_to_i(stripped, string)
                 end

        new(amount: amount)
      end

      private

      def amount_to_i(amount, string)
        Integer(amount)
      rescue StandardError
        raise ArgumentError, "#{string} is not a valid amount"
      end
    end

    def initialize(amount:)
      @amount = amount
    end

    attr_reader :amount

    # This method smells of :reek:FeatureEnvy
    def conditionally_pluralize(term)
      return term.singularize if amount == 1

      term.pluralize
    end
  end
end
