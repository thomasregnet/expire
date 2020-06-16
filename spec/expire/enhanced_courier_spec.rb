# frozen_string_literal: true

require 'support/shared_examples_for_couriers'

RSpec.describe Expire::EnhancedCourier do
  it_behaves_like 'a courier'

  describe 'output' do
    let(:backup) { double('Expire::AuditedBackup') }
    let(:receiver) { instance_double('IO') }
    let(:path) { Pathname.new('backups/1860-05-17T11_12_13_00') }

    let(:courier) { described_class.new(receiver: receiver) }

    describe '#on_keep' do
      before do
        allow(backup).to receive(:path).and_return(path)
        allow(backup).to receive(:reasons_to_keep).and_return(
          ['this is reason 1', 'this is reason 2']
        )
        allow(receiver).to receive(:puts)
      end

      it 'sends "keep ..." to the receiver' do
        courier.on_keep(backup)

        expect(receiver).to have_received(:puts)
          .with(%r{keeping #{path}})
      end

      it 'sends "  reason:" to the receiver' do
        courier.on_keep(backup)

        expect(receiver).to have_received(:puts).with(%r{reasons:})
      end

      it 'sends the first reason to the receiver' do
        courier.on_keep(backup)

        expect(receiver).to have_received(:puts).with(%r{this is reason 1})
      end

      it 'sends the second reason to the receiver' do
        courier.on_keep(backup)

        expect(receiver).to have_received(:puts).with(%r{this is reason 2})
      end
    end
  end
end
