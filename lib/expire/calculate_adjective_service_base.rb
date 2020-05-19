# frozen_string_literal: true

module Expire
  # Base Class for CalculateAdjectiveService classes
  class CalculateAdjectiveServiceBase < CalculateServiceBase
    def initialize(adjective:, noun:, **args)
      super(args)
      @adjective = adjective
      @noun      = noun
    end

    attr_reader :adjective, :noun
  end
end
