# frozen_string_literal: true

module Expire
  # Base Klass for Expire::Keep... classes
  class KeepBase
    def self.call(args)
      new(args).call
    end

    def initialize(adjective:, backups:, noun:, rules:)
      @adjective = adjective
      @backups   = backups
      @noun      = noun
      @rules     = rules
    end

    attr_reader :adjective, :backups, :noun, :rules
  end
end
