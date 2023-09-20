# frozen_string_literal: true

require "last_day_of"

RSpec.shared_examples "a year" do |year, last_day_of_february|
  month_lengths = {
    january: 31,
    february: nil,
    march: 31,
    april: 30,
    may: 31,
    june: 30,
    july: 31,
    august: 31,
    september: 30,
    october: 31,
    november: 30,
    december: 31
  }

  month_lengths[:february] = last_day_of_february

  month_lengths.each.with_index(1) do |(name, last_day), month|
    it "returns #{last_day} for #{name}" do
      expect(year.last_day_of(month)).to eq(last_day)
    end
  end
end

RSpec.describe "LastDayOf" do
  context "with a leap year" do
    it_behaves_like "a year", 2020, 29
  end

  context "with a usual year" do
    it_behaves_like "a year", 2019, 28
  end

  context "with a month out of range" do
    it "raises an ArgumentError" do
      expect { 1860.last_day_of(13) }
        .to raise_error(ArgumentError, /\Anot a month/)
    end
  end

  context "with a string as month" do
    it "raises an ArgumentError" do
      expect { 1860.last_day_of("february") }
        .to raise_error(ArgumentError, /\Anot a month/)
    end
  end
end
