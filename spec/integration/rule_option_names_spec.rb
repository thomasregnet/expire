# frozen_string_literal: true

RSpec.describe '`expire rule_option_names` command', type: :cli do
  let(:expected_output) do
    <<~OUT
      Usage:
        expire rule_option_names

      Options:
        -h, [--help], [--no-help]  # Display usage information

      List rule option names ordered by their rank
    OUT
  end

  it 'executes `expire help rule_option_names` command successfully' do
    output = `expire help rule_option_names`
    expect(output).to eq(expected_output)
  end
end
