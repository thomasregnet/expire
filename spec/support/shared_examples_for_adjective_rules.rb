# frozen_string_literal: true

require 'test_dates'

RSpec.shared_examples 'an adjective rule' do
  describe '#adjective' do
    it 'returns the right adjective' do
      expect(subject.adjective).to eq(adjective)
    end
  end

  describe '#apply' do
    let(:rule) { described_class.new(amount: 2) }

    let(:backups) do
      # backups = TestDates.create(months: 4..5, years: 1856..1860).map do |date|
      backups = TestDates.create(years: 1856..1860).map do |date|
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
        .to contain_exactly("keep 2 #{adjective} backups")
    end

    it 'adds a reason_to_keep to the second kept backup' do
      expect(rule.apply(backups).last.reasons_to_keep)
        .to contain_exactly("keep 2 #{adjective} backups")
    end
  end

  describe '#spacing' do
    it 'returns the right spacing' do
      expect(subject.spacing).to eq(spacing)
    end
  end
end
