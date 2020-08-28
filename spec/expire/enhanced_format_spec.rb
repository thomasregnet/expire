# frozen_string_literal: true

require 'support/shared_examples_for_formats'
require 'support/shared_examples_for_format_base_descendants'

RSpec.describe Expire::EnhancedFormat do
  it_behaves_like 'a format'
  it_behaves_like 'a FormatBase descendant'

  describe 'output' do
    let(:backup) { double('Expire::AuditedBackup') }
    let(:receiver) { instance_double('IO') }
    let(:path) { Pathname.new('backups/1860-05-17T11_12_13_00') }

    let(:format) { described_class.new(receiver: receiver) }

    describe '#on_keep' do
      before do
        allow(backup).to receive(:path).and_return(path)
        allow(backup).to receive(:reasons_to_keep).and_return(
          ['this is reason 1', 'this is reason 2']
        )
        allow(receiver).to receive(:puts)
      end

      it 'sends "keep ..." to the receiver' do
        format.on_keep(backup)

        expect(receiver).to have_received(:puts)
          .with(/keeping #{path}/)
      end

      it 'sends "  reason:" to the receiver' do
        format.on_keep(backup)

        expect(receiver).to have_received(:puts).with(/reasons:/)
      end

      it 'sends the first reason to the receiver' do
        format.on_keep(backup)

        expect(receiver).to have_received(:puts).with(/this is reason 1/)
      end

      it 'sends the second reason to the receiver' do
        format.on_keep(backup)

        expect(receiver).to have_received(:puts).with(/this is reason 2/)
      end
    end
  end
end
