# frozen_string_literal: true

RSpec.shared_examples 'an expiration calculation service' do
  it 'marks the expected backups to keep' do
    result = described_class.call(
      backups: backups,
      rules:   rules
    )

    # Note the splat operator
    expect(result.filter(&:keep?)).to contain_exactly(*expected_backups)
  end
end
