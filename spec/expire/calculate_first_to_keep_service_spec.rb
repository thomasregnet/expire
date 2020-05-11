# frozen_string_literal: true

require 'test_dates'
require 'spec_helper'

RSpec.describe Expire::CalculateFirstToKeepService do
  describe 'calculate yearly' do
    let(:test_backups) do
      TestDates.create(years: 1857..1860, months: 1..5, days: 17)
               .to_audited_backup_list
    end

    let(:rules) { Expire::Rules.new(yearly_to_keep: 3) }

    let(:backups) do
      first_to_keep = described_class.new(test_backups, rules)
      first_to_keep.call
      first_to_keep.backups
    end

    it 'keeps the expected amount of backups' do
      expect(backups.select(&:keep?).length).to eq(3)
    end

    it 'keeps the right first backup' do
      expect(backups.select(&:keep?).first.year).to eq(1860)
    end
  end
end
