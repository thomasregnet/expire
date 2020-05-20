# frozen_string_literal: true

module Expire
  # Base Class for CalculateAdjectiveService classes
  class CalculateAdjectiveServiceBase < CalculateServiceBase
    include Constants

    def initialize(adjective:, **args)
      super(args)
      @adjective = adjective
    end

    attr_reader :adjective

    def noun
      NOUN_FOR["#{adjective}"]
    end
  end
end
