# frozen_string_literal: true

module Expire
  # A simple expire rule consists of the amount of backups to keep an a name
  class SimpleRule
    def initialize(amount:, name:)
      @amount = amount
      @name   = name

      validate_amount
    end

    attr_reader :amount, :name

    private

    # This method smells of :reek:DuplicateMethodCall
    def validate_amount
      @amount = Integer(amount)
    rescue ArgumentError
      raise ArgumentError, "#{amount} is not a valid value for #{name}"
    rescue TypeError
      amount ||= 'nil'
      raise ArgumentError, "#{amount} is not a valid value for #{name}"
    end
  end
end
