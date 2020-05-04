# frozen_string_literal: true

module Expire
  # Representation of a single backup
  class Backup < Delegator
    def initialize(datetime, id = nil)
      @datetime = datetime
      @id = id
    end

    attr_reader :datetime, :id
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
  end
end
