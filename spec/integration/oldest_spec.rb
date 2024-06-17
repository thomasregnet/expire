# frozen_string_literal: true

RSpec.describe "`expire oldest` command", type: :cli do
  let(:expected_output) do
    <<~OUT
      Usage:
        expire oldest PATH

      Options:
        -h, [--help], [--no-help], [--skip-help]  # Display usage information

      Show the oldest backup
    OUT
  end

  it "executes `expire help oldest` command successfully" do
    output = `expire help oldest`
    expect(output).to eq(expected_output)
  end
end
