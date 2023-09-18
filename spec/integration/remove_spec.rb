# frozen_string_literal: true

RSpec.describe "`expire remove` command", type: :cli do
  let(:expected_output) do
    <<~OUT
      Usage:
        expire remove PATH

      Options:
        -h, [--help], [--no-help]  # Display usage information

      Remove PATH from the filesystem
    OUT
  end

  it "executes `expire help remove` command successfully" do
    output = `expire help remove`
    expect(output).to eq(expected_output)
  end
end
