# frozen_string_literal: true

require 'test_dates'

# Default TestDates for testing
class DefaultTestDates < TestDates
  def self.create
    new.create
  end

  def initialize
    @result = []
    super
  end

  attr_reader :result

  def create
    result << early_years
    result << until_may
    result << first_of_may
    result << rest_of_may

    result.flatten!(1)

    self
  end

  def to_backup_list
    Expire::BackupList.new(
      result.map do |time|
        path = Pathname.new("backups/#{time[0..5].join('-')}")

        Expire::Backup.new(
          time: Time.new(*time),
          path: path
        )
      end
    )
  end

  private

  # 57, 58, 59 - 60!
  def early_years
    TestDates.create(years: 1857..1859).to_a
  end

  def until_may
    TestDates.create(
      years:  1860,
      months: 1..4,
      # days:   (1..28).step(3)
      days:   (1..31).step(3)
    ).to_a
  end

  def first_of_may
    TestDates.create(
      years:  1860,
      months: 5,
      days:   1..14
    ).to_a
  end

  def rest_of_may
    TestDates.create(
      years:   1860,
      months:  5,
      days:    15..17,
      hours:   0..23,
      minutes: (0..59).step(20)
    ).to_a
  end
end
