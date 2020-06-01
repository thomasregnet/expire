# frozen_string_literal: true

require 'yaml'

module Expire
  # Set expiration rules
  class Rules
    include Constants

    def self.from_yaml(file)
      pathname = Pathname.new(file)
      content = pathname.read
      new(YAML.safe_load(content))
    end

    # This method reeks of :reek:Attribute
    attr_accessor :at_least

    STEP_ADJECTIVES.each { |adjective| attr_accessor adjective }
    STEP_ADJECTIVES.each do |adjective|
      attr_accessor "#{adjective}_for"
    end

    STEP_ADJECTIVES.each do |adjective|
      attr_accessor "#{adjective}_for_from_now"
    end

    def initialize(rules = {})
      rules.each { |name, value| send "#{name}=", value }

      yield self if block_given?
    end
  end
end
