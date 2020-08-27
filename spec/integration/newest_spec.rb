# frozen_string_literal: true

RSpec.describe "`expire newest` command", type: :cli do
  it "executes `expire help newest` command successfully" do
    output = `expire help newest`
    expected_output = <<-OUT
Usage:
  expire newest PATH

Options:
  -h, [--help], [--no-help]  # Display usage information

Show the newest backup
    OUT

    expect(output).to eq(expected_output)
  end
end
