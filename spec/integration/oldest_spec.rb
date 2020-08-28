RSpec.describe '`expire oldest` command', type: :cli do
  it 'executes `expire help oldest` command successfully' do
    output = `expire help oldest`
    expected_output = <<~OUT
      Usage:
        expire oldest PATH
      
      Options:
        -h, [--help], [--no-help]  # Display usage information
      
      Show the oldest backup
    OUT

    expect(output).to eq(expected_output)
  end
end
