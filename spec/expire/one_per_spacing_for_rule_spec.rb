# frozen_string_literal: true

require 'support/shared_examples_for_rules'
require 'test_dates'

RSpec.describe Expire::OnePerSpacingForRule do
  subject do
    described_class.new(
      amount:  1,
      spacing: 'week',
      unit:    'year'
    )
  end

  it_behaves_like 'a rule'

  it { should respond_to(:unit) }

  describe '.from_string' do
    context 'with the string "12_000 hour"' do
      let(:rule) { described_class.from_string('12_000 hour', spacing: 'day') }

      it 'has an amount of 12,000' do
        expect(rule.amount).to eq(12_000)
      end

      it 'uses "hour" as unit' do
        expect(rule.unit).to eq('hour')
      end
    end

    context 'with the string "3 days"' do
      let(:rule) { described_class.from_string('3 days', spacing: 'day') }

      it 'has an amount of 3' do
        expect(rule.amount).to eq(3)
      end

      it 'uses "day" as unit' do
        expect(rule.unit).to eq('day')
      end
    end

    context 'with the string "12 weeks"' do
      let(:rule) { described_class.from_string('12 weeks', spacing: 'day') }

      it 'has an amount of 12' do
        expect(rule.amount).to eq(12)
      end

      it 'uses "week" as unit' do
        expect(rule.unit).to eq('week')
      end
    end

    context 'with the string "24.months"' do
      let(:rule) { described_class.from_string('24.months', spacing: 'day') }

      it 'has an amount of 24' do
        expect(rule.amount).to eq(24)
      end

      it 'uses "month" as unit' do
        expect(rule.unit).to eq('month')
      end
    end

    context 'with the string "10&.%YEARS"' do
      let(:rule) { described_class.from_string('10&.%YEARS', spacing: 'day') }

      it 'has an amount of 10' do
        expect(rule.amount).to eq(10)
      end

      it 'uses "year" as unit' do
        expect(rule.unit).to eq('year')
      end
    end

    context 'with the string "333 bad string"' do
      it 'raises an ArgumentError' do
        expect { described_class.from_string('333 bad string', spacing: 'day') }
          .to raise_error(ArgumentError, '333 bad string is not a valid period')
      end
    end
  end

  describe '#apply' do
    let(:backups) do
      backups = []
      datetimes = TestDates.create(years: 1850..1860)
      datetimes.each do |datetime|
        backups << Expire::NewBackup.new(
          datetime: DateTime.new(*datetime),
          path:     datetime.to_s
        )
      end
      Expire::Backups.new(backups)
    end

    let(:rule) do
      described_class.new(
        amount:  5,
        unit:    'years',
        spacing: 'year'
      )
    end

    context 'with a reference_time' do
      let(:reference_time) { DateTime.new(1862, 9, 17, 12, 0, 0) }

      before { rule.apply(backups, reference_time) }

      it 'keeps the expected amount of backups' do
        expect(backups.keep.length).to eq(3)
      end
    end

    context 'without a reference_time' do
      before { rule.apply(backups) }

      it 'keeps 5 backups' do
        expect(backups.keep.length).to eq(5)
      end
    end
  end
end