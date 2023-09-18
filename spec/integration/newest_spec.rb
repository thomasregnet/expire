# frozen_string_literal: true

RSpec.describe "`expire newest` command", type: :cli do
  let(:expected_output) do
    <<~OUT
      Usage:
        expire newest PATH

      Options:
        -h, [--help], [--no-help]  # Display usage information

      Show the newest backup
    OUT
  end

  it "executes `expire help newest` command successfully" do
    output = `expire help newest`
    expect(output).to eq(expected_output)
  end
end
