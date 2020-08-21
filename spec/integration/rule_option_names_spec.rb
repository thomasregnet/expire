RSpec.describe "`expire rule_option_names` command", type: :cli do
  it "executes `expire help rule_option_names` command successfully" do
    output = `expire help rule_option_names`
    expected_output = <<-OUT
Usage:
  expire rule_option_names

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
