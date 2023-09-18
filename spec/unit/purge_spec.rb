# frozen_string_literal: true

require "expire/commands/purge"

RSpec.describe Expire::Commands::Purge do
  let(:output) { StringIO.new }
  let(:path) { "tmp/backups" }
  let(:options) { {keep_most_recent: 3} }

  before do
    backup_path = "tmp/backups"
    FileUtils.rm_rf("tmp/backups")
    FileUtils.mkdir("tmp/backups")

    %w[2020-04-29-09-12 2020-05-28-09-15].each do |backup_date|
      FileUtils.mkpath("#{backup_path}/#{backup_date}")
    end
  end

  it "executes `purge` command successfully" do
    command = described_class.new(path, options)
    command.execute(output: output)
    expect(output.string).to eq("")
  end
end
