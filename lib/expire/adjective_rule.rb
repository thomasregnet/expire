# frozen_string_literal: true

module Expire
  # Base class for rules with an adjective in their name
  class AdjectiveRule < Rule
    include Constants

    def self.from_value(value)
    end

    def spacing
      match = class_name.downcase.match(/(hourly|daily|weekly|monthly|yearly)/)

      return unless match

      NOUN_FOR[match[1]]
    end

    private

    def class_name
      self.class.name
    end
  end
end
