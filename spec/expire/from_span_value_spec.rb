# frozen_string_literal: true

module Expire
  # Dummy class For testing Expire::FromSpanValue
  class TestFromSpanValue
    extend Expire::FromSpanValue

    def initialize(amount:, unit:, **args)
      @amount = amount
      @args   = args
      @unit   = unit
    end

    attr_reader :amount, :args, :unit
  end
end

RSpec.describe Expire::FromSpanValue do
  good_test_params = [
    ['1 hour',   1, 'hour'],
    ['3 hours',  3, 'hour'],
    ['1 day',    1, 'day'],
    ['3 days',   3, 'day'],
    ['1 week',   1, 'week'],
    ['3 weeks',  3, 'week'],
    ['1 month',  1, 'month'],
    ['3 months', 3, 'month'],
    ['1 year',   1, 'year'],
    ['3 years',  3, 'year'],

    ['  5   years ',    5, 'year'],
    ['5.years',          5, 'year'],
    ['18_60 year',    1860, 'year'],
    ['18_60_5_17 year',    1860517, 'year']
  ]

  good_test_params.each do |test_params|
    context "with a value of \"#{test_params[0]}\"" do
      let(:rule) { Expire::TestFromSpanValue.from_value(test_params[0]) }

      it "has an amount of #{test_params[1]}" do
        expect(rule.amount).to eq(test_params[1])
      end

      it "has an unit of \"#{test_params[2]}\"" do
        expect(rule.unit).to eq(test_params[2])
      end
    end
  end

  bad_test_values = [
    '_123 days',
    '123_ years',
    'no ruby'
  ]

  bad_test_values.each do |value|
    context "with the value \"#{value}\"" do
      it 'raises an ArgumentError' do
        expect { Expire::TestFromSpanValue.from_value(value) }
          .to raise_error(ArgumentError) # , /is not a valid span value/)
      end
    end
  end
end
