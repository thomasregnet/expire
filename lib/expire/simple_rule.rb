# frozen_string_literal: true

module Expire
  # A simple expire rule consists of the amount of backups to keep an a name
  class SimpleRule
    class << self
      def from_string(string, name:)
        stripped = string.strip.downcase

        amount = case stripped
                 when 'all' then -1
                 when 'none' then 0
                 else
                   amount_to_i(stripped, string, name)
                 end

        new(amount: amount, name: name)
      end

      private

      def amount_to_i(amount, string, name)
        Integer(amount)
      rescue StandardError
        raise ArgumentError, "#{string} is not a valid value for #{name}"
      end
    end

    # private_class_method :amount_to_i

    def initialize(amount:, name:)
      @amount = amount
      @name   = name
    end

    attr_reader :amount, :name
  end
end
