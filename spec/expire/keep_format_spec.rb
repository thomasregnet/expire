# frozen_string_literal: true

require 'support/shared_examples_for_formats'

RSpec.describe Expire::KeepFormat do
  it_behaves_like 'a format'

  describe '#on_keep' do
    let(:backup) { instance_double('Expire::Backup') }
    let(:receiver) { instance_double('IO') }
    let(:pathname) { Pathname.new('backups/2020-16-16T21:15:16') }

    let(:format) { described_class.new(receiver: receiver) }

    before do
      allow(backup).to receive(:path).and_return(pathname)
      allow(receiver).to receive(:puts)
    end

    it 'sends the path as message to the receiver' do
      format.on_keep(backup)

      expect(receiver).to have_received(:puts).with(pathname.to_s)
    end
  end
end