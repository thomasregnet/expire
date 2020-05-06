# frozen_string_literal: true

module Expire
  # Set expiration rules
  class Rules
    include Constants

    STEP_WIDTHS.each do |_, adjective|
      attr_accessor "#{adjective}_to_keep"
    end

    def initialize(rules = {})
      rules.each { |name, value| send "#{name}=", value }

      yield self if block_given?
    end
  end
end
