# frozen_string_literal: true

require 'spec_helper'
require 'default_test_dates'
require 'support/shared_examples_for_expiration_calculations'

RSpec.describe Expire::CalculateService do
  describe 'integration' do
    rules = Expire::Rules.new(
      hourly:  3,
      daily:   3,
      weekly:  3,
      monthly: 3,
      yearly:  3
    )

    it_behaves_like 'an expiration calculation service' do
      let(:backups) { DefaultTestDates.create }
      let(:rules) { rules }
      let(:expected_backups) do
        [
          Expire::Backup.new(DateTime.new(1860, 5, 17, 23, 40, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 17, 22, 40, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 17, 21, 40, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 16, 23, 40, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 15, 23, 40, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 13, 12, 0, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 6, 12, 0, 0)),
          Expire::Backup.new(DateTime.new(1860, 4, 28, 12, 0, 0)),
          Expire::Backup.new(DateTime.new(1860, 3, 28, 12, 0, 0)),
          Expire::Backup.new(DateTime.new(1859, 5, 17, 12, 0, 0)),
          Expire::Backup.new(DateTime.new(1858, 5, 17, 12, 0, 0))
        ]
      end
    end
  end

  describe 'calculate yearly' do
    let(:backups) do
      TestDates.create(years: 1860..1869, months: 1..5).to_backup_list
    end

    let(:rules) { Expire::Rules.new(yearly: 5) }

    let(:result) do
      described_class.call(
        backups: backups,
        rules:   rules
      )
    end

    it 'keeps the expected amount of backups' do
      expect(result.keep_count).to eq(5)
    end

    it 'expires the expected amount of backups' do
      expect(result.expired_count).to eq(45)
    end

    it 'keeps the expected backups' do
      expect(result.keep.first.year).to eq(1869)
    end
  end
end
