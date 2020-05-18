# frozen_string_literal: true

require 'test_dates'
require 'support/shared_examples_for_keep_until_services'
require 'support/shared_examples_for_keep_services'

RSpec.describe Expire::KeepIntervalForService do
  it_behaves_like 'a keep service' do
    let(:constructor_args) {{}} # { { now: :fake_now } }
  end

  describe 'hourly_for' do
    it_behaves_like 'a keep until service' do
      let(:adjective) { :hourly }
      let(:noun) { :hour }
      let(:build_rules_with) { { hourly_for: '2 hours' } }
      let(:build_backups_with) { { hours: 9..12, minutes: (1..59).step(10) } }
      let(:expected_backups) do
        [
          Expire::Backup.new(DateTime.new(1860, 5, 17, 12, 51, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 17, 11, 51, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 17, 10, 51, 0))
        ]
      end
    end
  end

  describe 'yearly_for' do
    it_behaves_like 'a keep until service' do
      let(:adjective) { :yearly }
      let(:noun) { :year }
      # let(:now) { DateTime.new(1860, 1, 1, 12, 0, 0) }
      let(:build_rules_with) { { yearly_for: '2 years' } }
      let(:build_backups_with) { { years: 1857..1860 } }
      let(:expected_backups) do
        [
          Expire::Backup.new(DateTime.new(1860, 5, 17, 12, 0, 0)),
          Expire::Backup.new(DateTime.new(1859, 5, 17, 12, 0, 0)),
          Expire::Backup.new(DateTime.new(1858, 5, 17, 12, 0, 0))
        ]
      end
    end
  end
end
