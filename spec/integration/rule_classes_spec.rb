# frozen_string_literal: true

RSpec.describe '`expire rule_classes` command', type: :cli do
  it 'executes `expire help rule_classes` command successfully' do
    output = `expire help rule_classes`
    expected_output = <<~OUT
      Usage:
        expire rule_classes
      
      Options:
        -h, [--help], [--no-help]  # Display usage information
      
      Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
