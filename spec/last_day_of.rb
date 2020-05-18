# frozen_string_literal: true

require 'date'

# Integer#last_day_of(month)
class Integer
  MONTH_LENGTHS = {
    1 => 31,
    3 => 31,
    4 => 30,
    5 => 31,
    6 => 30,
    7 => 31,
    8 => 31,
    9 => 30,
    10 => 31,
    11 => 30,
    12 => 31
  }.freeze

  def last_day_of(month)
    if month == 2
      return Date.leap?(self) ? 29 : 28
    end

    return MONTH_LENGTHS[month] if MONTH_LENGTHS.key?(month)

    raise ArgumentError, "not a month: #{month}"
  end
end
