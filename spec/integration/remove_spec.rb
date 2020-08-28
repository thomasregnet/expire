# frozen_string_literal: true

RSpec.describe '`expire remove` command', type: :cli do
  it 'executes `expire help remove` command successfully' do
    output = `expire help remove`
    expected_output = <<~OUT
      Usage:
        expire remove
      
      Options:
        -h, [--help], [--no-help]  # Display usage information
      
      Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
