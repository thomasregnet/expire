# frozen_string_literal: true

require 'support/shared_examples_for_reporters'
require 'support/shared_examples_for_report_base_descendants'

RSpec.describe Expire::ReportExpired do
  it_behaves_like 'a reporter'
  it_behaves_like 'a ReportBase descendant'

  describe '#on_keep' do
    let(:backup) { instance_double('Expire::Backup') }
    let(:receiver) { instance_double('IO') }
    let(:pathname) { Pathname.new('backups/2020-16-16T21:15:16') }

    let(:report) { described_class.new(receiver: receiver) }

    before do
      allow(backup).to receive(:pathname).and_return(pathname)
      allow(receiver).to receive(:puts)
    end

    it 'sends the path as message to the receiver' do
      report.before_purge(backup)

      expect(receiver).to have_received(:puts).with(pathname.to_s)
    end
  end
end
