# frozen_string_literal: true

require 'support/shared_examples_for_rules'
require 'test_dates'

RSpec.describe Expire::AdjectiveForRule do
  subject { described_class.new(amount: 1, unit: 'year') }

  # it_behaves_like 'a rule'

  it { should respond_to(:unit) }

  describe '.from_string' do
    context 'with the string "12_000 hour"' do
      let(:rule) { described_class.from_string('12_000 hour') }

      it 'has an amount of 12,000' do
        expect(rule.amount).to eq(12_000)
      end

      it 'uses "hour" as unit' do
        expect(rule.unit).to eq('hour')
      end
    end

    context 'with the string "3 days"' do
      let(:rule) { described_class.from_string('3 days') }

      it 'has an amount of 3' do
        expect(rule.amount).to eq(3)
      end

      it 'uses "day" as unit' do
        expect(rule.unit).to eq('day')
      end
    end

    context 'with the string "12 weeks"' do
      let(:rule) { described_class.from_string('12 weeks') }

      it 'has an amount of 12' do
        expect(rule.amount).to eq(12)
      end

      it 'uses "week" as unit' do
        expect(rule.unit).to eq('week')
      end
    end

    context 'with the string "24.months"' do
      let(:rule) { described_class.from_string('24.months') }

      it 'has an amount of 24' do
        expect(rule.amount).to eq(24)
      end

      it 'uses "month" as unit' do
        expect(rule.unit).to eq('month')
      end
    end

    context 'with the string "10&.%YEARS"' do
      let(:rule) { described_class.from_string('10&.%YEARS') }

      it 'has an amount of 10' do
        expect(rule.amount).to eq(10)
      end

      it 'uses "year" as unit' do
        expect(rule.unit).to eq('year')
      end
    end

    context 'with the string "333 bad string"' do
      it 'raises an ArgumentError' do
        expect { described_class.from_string('333 bad string') }
          .to raise_error(ArgumentError, '333 bad string is not a valid period')
      end
    end
  end

  # describe '#apply' do
  #   let(:backups) do
  #     backups = []
  #     datetimes = TestDates.create(years: 1850..1860, months: 4..5)
  #     datetimes.each do |datetime|
  #       backups << Expire::Backup.new(
  #         datetime: DateTime.new(*datetime),
  #         path:     datetime.to_s
  #       )
  #     end
  #     Expire::Backups.new(backups)
  #   end

  #   let(:rule) do
  #     described_class.new(amount: 3, unit: 'year')
  #   end

  #   context 'with a reference_time' do
  #     let(:reference_time) { DateTime.new(1861, 9, 17, 12, 0, 0) }

  #     before { rule.apply(backups, reference_time) }

  #     it 'keeps the expected amount of backups' do
  #       expect(backups.keep).to contain_exactly(
  #         Expire::Backup.new(
  #           datetime: DateTime.new(1859, 5, 17, 12, 0, 0),
  #           path:     :fake_path
  #         ),
  #         Expire::Backup.new(
  #           datetime: DateTime.new(1860, 5, 17, 12, 0, 0),
  #           path:     :fake_path
  #         )
  #       )
  #     end
  #   end

  #   context 'without a reference_time' do
  #     let(:expected_backups) do
  #       datetimes = TestDates.create(years: 1858..1860)
  #       backups = datetimes.map do |datetime|
  #         Expire::Backup.new(
  #           datetime: DateTime.new(*datetime),
  #           path:     datetime.to_s
  #         )
  #       end

  #       Expire::Backups.new(backups)
  #     end

  #     before { rule.apply(backups) }

  #     it 'keeps 5 backups' do
  #       expect(backups.keep).to contain_exactly(*expected_backups)
  #     end
  #   end
  # end
end
