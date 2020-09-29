# frozen_string_literal: true

require 'expire/commands/newest'
require 'fileutils'

RSpec.describe Expire::Commands::Newest do
  let(:output) { StringIO.new }
  let(:path) { 'tmp/aruba/backups' }
  let(:options) { {} }

  before do
    backup_path = Pathname.new('tmp/aruba/backups')
    FileUtils.rm_rf(backup_path)

    FileUtils.mkpath("#{backup_path}/1860-05-17T12_00_00")
    FileUtils.mkpath("#{backup_path}/1860-05-17T13_00_00")
  end

  it 'executes `newest` command successfully' do
    command = described_class.new(path, options)
    command.execute(output: output)
    expect(output.string).to eq("tmp/aruba/backups/1860-05-17T13_00_00\n")
  end
end
