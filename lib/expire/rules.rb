# frozen_string_literal: true

module Expire
  # Set expiration rules
  class Rules
    include Constants

    STEP_ADJECTIVES.each { |adjective| attr_accessor "#{adjective}_to_keep" }

    def initialize(rules = {})
      rules.each { |name, value| send "#{name}=", value }

      yield self if block_given?
    end
  end
end
