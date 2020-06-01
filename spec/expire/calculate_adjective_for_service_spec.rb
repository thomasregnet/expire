# frozen_string_literal: true

require 'test_dates'
require 'support/shared_examples_for_keep_until_services'
require 'support/shared_examples_for_calculate_adjective_for_services'

RSpec.describe Expire::CalculateAdjectiveForService do
  subject do
    described_class.new(
      adjective: :fake_adjective,
      backups:   :fake_backups,
      # noun:      :fake_noun,
      rules:     :fake_rules
    )
  end

  it_behaves_like 'a calculate adjective for service'

  describe 'hourly_for' do
    it_behaves_like 'a keep until service' do
      let(:adjective) { :hourly }
      let(:build_rules_with) { { hourly_for: '2 hours' } }
      let(:build_backups_with) { { hours: 9..12, minutes: (1..59).step(10) } }
      let(:expected_backups) do
        [
          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 12, 51, 0),
            path:     :fake_path
          ),
          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 11, 51, 0),
            path:     :fake_path
          ),
          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 10, 51, 0),
            path:     :fake_path
          )
        ]
      end
    end
  end

  describe 'yearly_for' do
    it_behaves_like 'a keep until service' do
      let(:adjective) { :yearly }
      let(:build_rules_with) { { yearly_for: '2 years' } }
      let(:build_backups_with) { { years: 1857..1860 } }
      let(:expected_backups) do
        [
          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 12, 0, 0),
            path:     :fake_path
          ),
          Expire::Backup.new(
            datetime: DateTime.new(1859, 5, 17, 12, 0, 0),
            path:     :fake_path
          ),
          Expire::Backup.new(
            datetime: DateTime.new(1858, 5, 17, 12, 0, 0),
            path:     :fake_path
          )
        ]
      end
    end
  end
end
