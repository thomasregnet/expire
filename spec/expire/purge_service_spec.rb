# frozen_string_literal: true

RSpec.describe Expire::PurgeService do
  describe '.call' do
    let(:backup_path)    { 'tmp/backups' }
    let(:expired_backup) { 'tmp/backups/2020-08-11_12_00_00' }
    let(:kept_backup)    { 'tmp/backups/2020-08-22_12_00_00' }

    before do
      FileUtils.rm_rf(backup_path)
      FileUtils.mkpath(expired_backup)
      FileUtils.mkpath(kept_backup)
    end

    context 'with valid options' do
      before do
        described_class.call('tmp/backups', keep_most_recent: 1)
      end

      it 'removes the expired backup' do
        expect(Pathname.new(expired_backup)).not_to exist
      end

      it 'keeps the unexpired backup' do
        expect(Pathname.new(kept_backup)).to exist
      end
    end

    context 'with the "simulate" option' do
      before do
        described_class.call('tmp/backups', keep_most_recent: 1, simulate: true)
      end

      it 'removes the expired backup' do
        expect(Pathname.new(expired_backup)).to exist
      end

      it 'keeps the unexpired backup' do
        expect(Pathname.new(kept_backup)).to exist
      end
    end

    context 'with paths from STDIN' do
      before do
        # Idea to use a StringIO object was found here:
        # https://hackernoon.com/how-to-use-rspec-from-basics-to-testing-user-input-i03k36m3
        io = StringIO.new("#{expired_backup}\n#{kept_backup}")
        $stdin = io
        described_class.call('-', keep_most_recent: 1)
      end

      it 'removes the expired backup' do
        expect(Pathname.new(expired_backup)).not_to exist
      end

      it 'keeps the unexpired backup' do
        expect(Pathname.new(kept_backup)).to exist
      end
    end

    context 'with an invalid format' do
      let(:opts) { { format: 'no_such_format', keep_most_recent: 1 } }

      it 'raises an ArgumentError' do
        expect { described_class.call(backup_path, opts) }
          .to raise_error ArgumentError, 'unknown format "no_such_format"'
      end
    end

    context 'without any rules' do
      it 'raises a NoRulesError' do
        expect { described_class.call(backup_path, {}) }
          .to raise_error Expire::NoRulesError, 'Will not purge without rules'
      end
    end

    context 'with an unsorted BackupList' do
      let(:backup_list) { instance_double('Expire::BackupList') }
      let(:purge_service) { described_class.new('tmp/backups', {}) }

      before do
        # return an array with a value so rules.any? returns true
        allow(purge_service).to receive(:rules).and_return([1])
        allow(purge_service).to receive(:annotated_backup_list).and_return(backup_list)
        # return an empty array to let #each does nothing
        allow(backup_list).to receive(:sort).and_return([])
      end

      it 'calls sort on the BackupList' do
        purge_service.call
        expect(backup_list).to have_received(:sort)
      end
    end
  end

  describe '#report (private)' do
    context 'when the wanted format is "none"' do
      it 'returns an instance of Expire::ReportNull' do
        purge_service = described_class.new('path', format: 'none')
        expect(purge_service.send(:report))
          .to be_instance_of(Expire::ReportNull)
      end
    end

    context 'when the wanted format is nil' do
      it 'returns an instance of Expire::ReportNull' do
        purge_service = described_class.new('path', most_recent: 1)
        expect(purge_service.send(:report))
          .to be_instance_of(Expire::ReportNull)
      end
    end

    context 'when the wanted format is "enhanced"' do
      it 'returns an instance of Expire::ReportEnhanced' do
        purge_service = described_class.new('path', format: 'enhanced')
        expect(purge_service.send(:report))
          .to be_instance_of(Expire::ReportEnhanced)
      end
    end
  end
end
