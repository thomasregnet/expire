# frozen_string_literal: true

require 'expire/commands/remove'

RSpec.describe Expire::Commands::Remove do
  before { FileUtils.mkpath('tmp/aruba/to_be_deleted') }

  it 'executes `remove` command successfully' do
    output = StringIO.new
    options = { path: 'tmp/aruba/to_be_deleted' }
    command = described_class.new(**options)

    command.execute(output: output)

    expect(output.string).to eq("removed tmp/aruba/to_be_deleted\n")
  end
end
