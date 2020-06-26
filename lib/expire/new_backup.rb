# frozen_string_literal: true

module Expire
  # Representation of a single backup
  class NewBackup < Delegator
    include Comparable

    def initialize(datetime:, path:)
      @datetime = datetime
      @path     = path

      @reasons_to_keep = []
    end

    attr_reader :datetime, :path, :reasons_to_keep
    alias __getobj__ datetime

    def same_hour?(other)
      return false unless same_day?(other)
      return true if hour == other.hour

      false
    end

    def same_day?(other)
      return false unless same_week?(other)
      return true if day == other.day

      false
    end

    def same_week?(other)
      return false unless same_year?(other)
      return true if cweek == other.cweek

      false
    end

    def same_month?(other)
      return false unless same_year?(other)
      return true if month == other.month

      false
    end

    def same_year?(other)
      year == other.year
    end

    # The <=> method seems not to be delegated so we need to implement it
    # Note that this Class includes the Comparable module
    def <=>(other)
      datetime <=> other.datetime
    end

    def add_reason_to_keep(reason)
      reasons_to_keep << reason
    end

    # def datetime
    #   backup.datetime
    # end

    def expired?
      reasons_to_keep.empty?
    end

    def keep?
      reasons_to_keep.any?
    end
  end
end
