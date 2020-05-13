# frozen_string_literal: true

require 'spec_helper'
require 'test_dates'

RSpec.describe Expire::Calculate do
  describe 'calculate yearly' do
    let(:result) do
      described_class.call(
        TestDates.create(years: 1860..1869, months: 1..5).to_backup_list,
        Expire::Rules.new(yearly: 5)
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
