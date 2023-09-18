# frozen_string_literal: true

module Expire
  # Representation of a single backup
  class Backup < Delegator
    include Comparable

    def initialize(time:, pathname:)
      @time = time
      @pathname = pathname

      # @reasons_to_keep is a Set so a reason can added multiple times
      # but appears only once
      @reasons_to_keep = Set.new
    end

    attr_reader :time, :pathname, :reasons_to_keep
    alias_method :__getobj__, :time

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
      time <=> other.time
    end

    def add_reason_to_keep(reason)
      reasons_to_keep << reason
    end

    # def time
    #   backup.time
    # end

    def cweek
      time&.strftime("%V").to_i
    end

    def expired?
      reasons_to_keep.empty?
    end

    def keep?
      reasons_to_keep.any?
    end

    def to_s
      time.strftime("%Y-%m-%dT%H:%M")
    end
  end
end
