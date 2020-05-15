# frozen_string_literal: true

require 'forwardable'

module Expire
  # All Backups go here
  class BackupList
    include Enumerable
    extend Forwardable

    def initialize(backups = [])
      @backups = backups.sort.reverse
    end

    attr_reader :backups
    def_delegators :backups, :each, :<<

    def one_per(interval)
      return [] unless any?

      result = [first]
      message = "same_#{interval}?"

      sort.reverse.each do |backup|
        result << backup unless backup.send(message, result.last)
      end

      result
    end

    def latest(amount = 1)
      backups.sort.reverse.first(amount)
    end

    # Enumerable#reverse returns an array but we need a BackupList
    def reverse
      self.class.new(backups.reverse)
    end

    # Enumerable#sort returns an array but we need a BackupList
    def sort
      self.class.new(backups.sort)
    end
  end
end
