# frozen_string_literal: true

module Expire
  # Set expiration rules
  class Rules
    include Constants

    # This method reeks of :reek:Attribute
    attr_accessor :at_least

    STEP_ADJECTIVES.each { |adjective| attr_accessor adjective }
    STEP_ADJECTIVES.each do |adjective|
      attr_accessor "#{adjective}_for"
    end

    def initialize(rules = {})
      rules.each { |name, value| send "#{name}=", value }

      yield self if block_given?
    end
  end
end
