# frozen_string_literal: true

require 'expire/commands/oldest'
require 'fileutils'

RSpec.describe Expire::Commands::Oldest do
  let(:output) { StringIO.new }
  let(:options) { {} }

  describe 'with an directory as input' do
    let(:path) { 'tmp/backups' }

    before do
      pathname = Pathname.new(path)
      FileUtils.rm_rf(pathname)

      FileUtils.mkpath("#{pathname}/1860-05-17T12_00_00")
      FileUtils.mkpath("#{pathname}/1860-05-17T13_00_00")
    end

    after { FileUtils.rm_rf(path) }

    it 'executes `oldest` command successfully' do
      command = described_class.new(path, options)
      command.execute(output: output)
      expect(output.string).to eq("tmp/backups/1860-05-17T12_00_00\n")
    end
  end

  describe 'with input from STDIN' do
    it 'executes `oldest` command successfully' do
      $stdin = StringIO.new("/tsv/1860-05-17T12_00_00\n/tsv/1860-05-17T13_00_00\n")
      command = described_class.new('-', options)
      command.execute(output: output)
      expect(output.string).to eq("/tsv/1860-05-17T12_00_00\n")
    end
  end
end
