# frozen_string_literal: true

module Expire
  # Base class for CalculateService classes
  class CalculateServiceBase
    def self.call(args = {})
      new(args).call
    end

    def initialize(backups:, rules:)
      @backups = backups
      @rules   = rules
    end

    attr_reader :backups, :rules

    def call
      raise NotImplementedError, "#call not implemented in #{self.class}"
    end
  end
end
