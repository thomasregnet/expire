# frozen_string_literal: true

module Expire
  # Set expiration rules
  class Rules
    def initialize(rules = {})
      rules.each { |name, value| send "#{name}=", value }

      yield self if block_given?
    end

    attr_accessor :hourly_to_keep, :daily_to_keep, :weekly_to_keep
    attr_accessor :monthly_to_keep, :yearly_to_keep
  end
end
