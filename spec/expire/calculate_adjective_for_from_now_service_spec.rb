# frozen_string_literal: true

require 'test_dates'
RSpec.describe Expire::CalculateAdjectiveForFromNowService do
  describe 'hourly' do
    let(:backups) do
      TestDates.create(
        hours:   10..23,
        minutes: (1..59).step(30)
      ).to_audited_backup_list
    end

    let(:rules) { Expire::Rules.new(hourly_for_from_now: '12 hours') }
    let(:now) { backups.max + 10.hours }

    before do
      described_class.call(
        adjective: :hourly,
        backups:   backups,
        noun:      :hour,
        now:       now,
        rules:     rules
      )
    end

    it 'keeps the expected backups' do
      expect(backups.filter(&:keep?).length).to eq(3)
    end
  end
end
