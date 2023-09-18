# frozen_string_literal: true

RSpec.describe "`expire rule_classes` command", type: :cli do
  let(:expected_output) do
    <<~OUT
      Usage:
        expire rule_classes

      Options:
        -h, [--help], [--no-help]  # Display usage information

      List rule classes ordered by their rank
    OUT
  end

  it "executes `expire help rule_classes` command successfully" do
    output = `expire help rule_classes`
    expect(output).to eq(expected_output)
  end
end
