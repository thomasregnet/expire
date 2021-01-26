# frozen_string_literal: true

require 'support/shared_examples_for_reporters'
require 'support/shared_examples_for_report_base_descendants'

RSpec.describe Expire::ReportSimple do
  it_behaves_like 'a reporter'
  it_behaves_like 'a ReportBase descendant'

  describe 'messages' do
    let(:backup) { instance_double('Expire::AuditedBackup') }
    let(:receiver) { instance_double('IO') }
    let(:pathname) { Pathname.new('backups/2020-06-01-11-29') }

    let(:report) { described_class.new(receiver: receiver) }

    before do
      allow(backup).to receive(:pathname).and_return(pathname)
      allow(receiver).to receive(:puts)
    end

    describe 'after_purge' do
      it 'sends the expected messages to the receiver' do
        report.after_purge(backup)

        expect(receiver).to have_received(:puts)
          .with(%r{purged backups/2020-06-01-11-29})
      end
    end

    describe '#on_keep' do
      it 'sends the expected messages to the receiver' do
        report.on_keep(backup)

        expect(receiver).to have_received(:puts)
          .with(%r{keeping backups/2020-06-01-11-29})
      end
    end
  end
end
