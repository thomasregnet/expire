# frozen_string_literal: true

require "expire/commands/remove"

RSpec.describe Expire::Commands::Remove do
  let(:to_be_deleted) { Pathname.new(File.join("tmp", "to_be_deleted")) }

  before { FileUtils.mkpath(to_be_deleted) }

  it "executes `remove` command successfully" do
    output = StringIO.new
    command = described_class.new(path: to_be_deleted)

    command.execute(output: output)

    expect(output.string).to eq("removed tmp/to_be_deleted\n")
  end

  it "removes the path" do
    described_class.new(path: to_be_deleted).execute
    expect(to_be_deleted).not_to exist
  end
end
