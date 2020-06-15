RSpec.describe "`expire purge` command", type: :cli do
  it "executes `expire help purge` command successfully" do
    output = `expire help purge`
    expected_output = <<-OUT
Usage:
  expire purge PATH

Options:
  -h, [--help], [--no-help]      # Display usage information
  -f, [--format=FORMAT]          # output format
                                 # Default: none
                                 # Possible values: none, simple
  -r, [--rules-file=RULES_FILE]  # read expire-rules from file

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
