# frozen_string_literal: true

require "forwardable"

module Expire
  # All Backups go here
  class BackupList
    include Enumerable
    extend Forwardable

    def initialize(backups = [])
      # @backups = backups.sort.reverse
      @backups = backups
    end

    attr_reader :backups

    def_delegators :backups, :each, :empty?, :last, :length, :<<

    def one_per(noun)
      backups_per_noun = self.class.new
      return backups_per_noun unless any?

      reversed = sort.reverse

      backups_per_noun << reversed.first

      message = "same_#{noun}?"

      reversed.each do |backup|
        backups_per_noun << backup unless backup.send(message, backups_per_noun.last)
      end

      backups_per_noun
    end

    def most_recent(amount = 1)
      self.class.new(sort.reverse.first(amount))
    end

    def newest
      backups.max
    end

    def oldest
      backups.min
    end

    def not_older_than(reference_time)
      sort.select { |backup| backup.time >= reference_time }
    end

    def expired
      self.class.new(backups.select(&:expired?))
    end

    def expired_count
      expired.length
    end

    def keep
      self.class.new(backups.select(&:keep?))
    end

    def keep_count
      keep.length
    end
  end
end
