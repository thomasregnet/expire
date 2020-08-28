# frozen_string_literal: true

require 'expire/commands/purge'

RSpec.describe Expire::Commands::Purge do
  before do
    backup_path = 'tmp/backups'
    FileUtils.rm_rf('tmp/backups')
    FileUtils.mkdir('tmp/backups')

    %w[2020-04-29-09-12 2020-05-28-09-15].each do |backup_date|
      FileUtils.mkpath("#{backup_path}/#{backup_date}")
    end
  end

  it 'executes `purge` command successfully' do
    output = StringIO.new
    path = 'tmp/backups'
    options = { most_recent: 3 }
    command = described_class.new(path, options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
