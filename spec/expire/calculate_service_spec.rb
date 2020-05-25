# frozen_string_literal: true

require 'spec_helper'
require 'default_test_dates'
require 'test_dates'
require 'support/shared_examples_for_expiration_calculations'
require 'support/shared_examples_for_calculate_services'

RSpec.describe Expire::CalculateService do
  # subject { described_class.new(backups: [], rules: :fake_rules) }
  subject do
    described_class.new(
      backups: Expire::BackupList.new([]),
      rules:   :fake_rules
    )
  end

  it_behaves_like 'a calculate service'

  describe 'integration' do
    rules = Expire::Rules.new(
      hourly:  3,
      daily:   3,
      weekly:  3,
      monthly: 3,
      yearly:  3
    )

    it_behaves_like 'an expiration calculation service' do
      let(:backups) { DefaultTestDates.create.to_backup_list }
      let(:rules) { rules }
      let(:expected_backups) do
        [
          Expire::Backup.new(DateTime.new(1860, 5, 17, 23, 40, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 17, 23, 20, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 17, 22, 40, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 17, 21, 40, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 16, 23, 40, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 15, 23, 40, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 13, 12, 0, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 6, 12, 0, 0)),
          Expire::Backup.new(DateTime.new(1860, 4, 30, 12, 0, 0)),
          Expire::Backup.new(DateTime.new(1860, 3, 31, 12, 0, 0)),
          Expire::Backup.new(DateTime.new(1859, 5, 17, 12, 0, 0)),
          Expire::Backup.new(DateTime.new(1858, 5, 17, 12, 0, 0))
        ]
      end
    end
  end

  describe 'keep at least' do
    context 'with 3 to keep' do
      let(:result) do
        described_class.call(
          backups: TestDates.create(days: 1..5).to_backup_list,
          rules:   Expire::Rules.new(at_least: 3)
        )
      end

      it 'keeps three backups' do
        expect(result.keep_count).to eq(3)
      end
    end
  end

  describe 'keep latest' do
    context 'without rules' do
      let(:result) do
        described_class.call(
          backups: TestDates.create(days: 15..17).to_backup_list,
          rules:   Expire::Rules.new
        )
      end

      it 'keeps two backups' do
        expect(result.keep_count).to eq(2)
      end

      it 'keeps the right first backup' do
        expect(result.keep[0].day).to eq(17)
      end

      it 'keeps the right second backup' do
        expect(result.keep[1].day).to eq(16)
      end

      it 'expires the right backups' do
        expect(result.expired[0].day).to eq(15)
      end
    end
  end

  describe '#keep_first_of_interval_until' do
    let(:result) do
      described_class.call(
        backups: TestDates.create(days: 1..4).to_backup_list,
        rules:   Expire::Rules.new(daily_for: '2 days')
      )
    end

    it 'keeps three backups' do
      expect(result.keep_count).to eq(3)
    end
  end
end
