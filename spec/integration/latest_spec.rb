RSpec.describe "`expire latest` command", type: :cli do
  it "executes `expire help latest` command successfully" do
    output = `expire help latest`
    expected_output = <<-OUT
Usage:
  expire latest PATH

Options:
  -h, [--help], [--no-help]  # Display usage information

Show the latest backup
    OUT

    expect(output).to eq(expected_output)
  end
end
