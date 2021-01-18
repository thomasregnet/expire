# frozen_string_literal: true

RSpec.describe Expire::GenerateBackupListService do
  describe '.call' do
    context 'with an path' do
      let(:path) { 'tmp/backups' }

      before do
        FileUtils.rm_rf(path)
        FileUtils.mkpath("#{path}/1860-05-17T12_00_00")
        FileUtils.mkpath("#{path}/1860-05-17T13_00_00")
      end

      after { FileUtils.rm_rf(path) }

      it 'returns an Expire::BackupList' do
        expect(described_class.call(path)).to be_instance_of(Expire::BackupList)
      end

      it 'returns a BackupList with two Backups' do
        expect(described_class.call(path).length).to eq(2)
      end
    end

    context 'with paths from STDIN' do
      before do
        $stdin = StringIO.new("tmp/1860-05-17T12_00_00\n1860-05-17T13_00_00\n")
      end

      it 'returns an Expire::BackupList' do
        expect(described_class.call('-')).to be_instance_of(Expire::BackupList)
      end

      it 'returns a BackupList with two Backups' do
        expect(described_class.call('-').length).to eq(2)
      end
    end
  end
end
