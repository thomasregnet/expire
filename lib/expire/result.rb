# frozen_string_literal: true

require 'forwardable'

module Expire
  # The resulting backup of a calculation
  class Result
    include Enumerable
    extend Forwardable

    def initialize(backups = [])
      @backups = backups
    end

    attr_reader :backups
    def_delegators :backups, :each, :<<

    def expired
      backups.select(&:expired?)
    end

    def keep
      backups.select(&:keep?)
    end
  end
end
