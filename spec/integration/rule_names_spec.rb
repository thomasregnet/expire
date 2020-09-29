# frozen_string_literal: true

RSpec.describe '`expire rule_names` command', type: :cli do
  let(:expected_output) do
    <<~OUT
      Usage:
        expire rule_names

      Options:
        -h, [--help], [--no-help]  # Display usage information

      Command description...
    OUT
  end

  it 'executes `expire help rule_names` command successfully' do
    output = `expire help rule_names`
    expect(output).to eq(expected_output)
  end
end
