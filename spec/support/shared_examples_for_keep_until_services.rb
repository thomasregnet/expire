# frozen_string_literal: true

RSpec.shared_examples 'a keep until service' do
  describe '.call' do
    let(:backups) do
      TestDates.create(build_backups_with).to_audited_backup_list
    end
    let(:rules) { Expire::Rules.new(build_rules_with) }

    before do
      described_class.call(
        adjective: adjective,
        backups:   backups,
        rules:     rules
      )
    end

    it 'marks the expected backups as to be kept' do
      expect(backups.filter(&:keep?)).to contain_exactly(*expected_backups)
    end
  end
end
