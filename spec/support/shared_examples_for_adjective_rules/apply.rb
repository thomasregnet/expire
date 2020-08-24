# frozen_string_literal: true

require 'test_dates'

RSpec.shared_examples 'an applicable adjective rule' do
  describe '#apply' do
    let(:backups) do
      backups = TestDates.create(years: 1856..1860).map do |date|
        datetime = DateTime.new(*date)
        Expire::Backup.new(datetime: datetime, path: 'fake/path')
      end

      Expire::Backups.new(backups)
    end

    context 'with an amount of 2' do
      let(:rule) { described_class.new(amount: 2) }

      it 'keeps 2 backups' do
        expect(rule.apply(backups, :dummy_reference_datetime).length).to eq(2)
      end

      it 'keeps a backup from the year 1860' do
        expect(rule.apply(backups, :dummy_reference_datetime).first.year)
          .to eq(1860)
      end

      it 'keeps a backup from the year 1859' do
        expect(rule.apply(backups, :dummy_reference_datetime).last.year)
          .to eq(1859)
      end

      it 'adds a reason_to_keep to the first kept backup' do
        expect(rule.apply(backups, :du).first.reasons_to_keep)
          .to contain_exactly("keep 2 #{adjective} backups")
      end

      it 'adds a reason_to_keep to the second kept backup' do
        expect(rule.apply(backups, :dummy_reference_datetime)
          .last.reasons_to_keep)
          .to contain_exactly("keep 2 #{adjective} backups")
      end
    end

    context 'with an amount of 0' do
      let(:rule) { described_class.new(amount: 0) }

      it 'keeps all backups' do
        rule.apply(backups, :dummy_reference_datetime)
        expect(backups.keep_count).to eq(0)
      end
    end

    context 'with an amount of -1' do
      let(:rule) { described_class.new(amount: -1) }

      it 'keeps all backups' do
        rule.apply(backups, :dummy_reference_datetime)
        expect(backups.keep_count).to eq(backups.length)
      end
    end
  end
end
