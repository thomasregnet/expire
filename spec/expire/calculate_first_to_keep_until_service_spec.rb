# frozen_string_literal: true

require 'test_dates'

RSpec.describe Expire::CalculateFirstToKeepUntilService do
  describe 'hourly_to_keep_for' do
    let(:backups) do
      TestDates.create(hours: 9..12, minutes: (1..59).step(10))
               .to_audited_backup_list
    end

    let(:rules) { Expire::Rules.new(hourly_to_keep_for: '3 hours') }

    before do
      described_class.call(backups, rules, DateTime.new(1860, 5, 17, 13, 51, 0))
    end

    it 'marks the expected backups as kept' do
      expect(backups.filter(&:keep?)).to contain_exactly(
        Expire::Backup.new(DateTime.new(1860, 5, 17, 12, 51, 0)),
        Expire::Backup.new(DateTime.new(1860, 5, 17, 11, 51, 0)),
        Expire::Backup.new(DateTime.new(1860, 5, 17, 10, 51, 0))
      )
    end
  end

  describe 'yearly_to_keep_for' do
    let(:backups) do
      TestDates.create(years: 1857..1860).to_audited_backup_list
    end

    let(:rules) { Expire::Rules.new(yearly_to_keep_for: '2 years') }

    before do
      described_class.call(backups, rules, DateTime.new(1860, 1, 1, 12, 0, 0))
    end

    it 'marks the expected backups as kept' do
      expect(backups.filter(&:keep?)).to contain_exactly(
        Expire::Backup.new(DateTime.new(1860, 5, 17, 12, 0, 0)),
        Expire::Backup.new(DateTime.new(1859, 5, 17, 12, 0, 0)),
        Expire::Backup.new(DateTime.new(1858, 5, 17, 12, 0, 0))
      )
    end
  end
end
