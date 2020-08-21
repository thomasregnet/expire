RSpec.describe "`expire rule_names` command", type: :cli do
  it "executes `expire help rule_names` command successfully" do
    output = `expire help rule_names`
    expected_output = <<-OUT
Usage:
  expire rule_names

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
