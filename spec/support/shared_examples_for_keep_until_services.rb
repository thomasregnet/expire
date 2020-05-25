# frozen_string_literal: true

RSpec.shared_examples 'a keep until service' do
  it 'marks the expected backups to keep' do
    backups = TestDates.create(build_backups_with).to_audited_backup_list
    rules   = Expire::Rules.new(build_rules_with)

    described_class.call(
      adjective: adjective,
      backups:   backups,
      rules:     rules
    )

    # byebug
    # Note the splat operator
    expect(backups.filter(&:keep?)).to contain_exactly(*expected_backups)
  end
end
