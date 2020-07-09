# frozen_string_literal: true

require 'test_dates'

RSpec.describe Expire::OnePerSpacingRule do
  describe '#apply' do
    context 'keep two yearly backups' do
      let(:rule) { described_class.new(amount: 2, spacing: 'year') }

      let(:backups) do
        backups = TestDates.create(months: 4..5, years: 1856..1860).map do |date|
          datetime = DateTime.new(*date)
          Expire::Backup.new(datetime: datetime, path: 'fake/path')
        end

        Expire::Backups.new(backups)
      end


      it 'keeps 2 backups' do
        expect(rule.apply(backups).length).to eq(2)
      end

      it 'keeps a backup from the year 1860' do
        expect(rule.apply(backups).first.year).to eq(1860)
      end

      it 'keeps a backup from the year 1859' do
        expect(rule.apply(backups).last.year).to eq(1859)
      end

      it 'adds a reason_to_keep to the first kept backup' do
        expect(rule.apply(backups).first.reasons_to_keep)
          .to contain_exactly('keep 2 yearly backups')
      end

      it 'adds a reason_to_keep to the second kept backup' do
        expect(rule.apply(backups).last.reasons_to_keep)
          .to contain_exactly('keep 2 yearly backups')
      end
    end

    context 'keep one weekly backup' do
      let(:rule) { described_class.new(amount: 1, spacing: 'week') }

      let(:backups) do
        backups = TestDates.create(days: (1..30).step(3)).map do |date|
          datetime = DateTime.new(*date)
          Expire::Backup.new(datetime: datetime, path: 'fake/path')
        end

        Expire::Backups.new(backups)
      end

      it 'keeps 1 backup' do
        expect(rule.apply(backups).length).to eq(1)
      end

      it 'adds the right reason_to_keep to the kept backup' do
        expect(rule.apply(backups).first.reasons_to_keep)
          .to contain_exactly('keep 1 weekly backup')
      end
    end
  end
end
