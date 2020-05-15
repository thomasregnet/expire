# frozen_string_literal: true

RSpec.shared_examples 'an expiration calculation service' do
  it 'marks the expected backups to keep' do
    audited_backups = backups.to_backup_list

    result = described_class.call(
      backups: audited_backups,
      rules:   rules
    )

    # byebug
    # result = backups unless result.class == Expire::Result

    # Note the splat operator
    expect(result.filter(&:keep?)).to contain_exactly(*expected_backups)
  end
end
