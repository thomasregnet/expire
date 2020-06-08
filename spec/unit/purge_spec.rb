require 'expire/commands/purge'

RSpec.describe Expire::Commands::Purge do
  it "executes `purge` command successfully" do
    output = StringIO.new
    path = nil
    options = {}
    command = Expire::Commands::Purge.new(path, options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
