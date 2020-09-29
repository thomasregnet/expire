# frozen_string_literal: true

RSpec.describe Expire::PurgeService do
  describe '.call' do
    let(:backup_path)    { 'tmp/backups' }
    let(:expired_backup) { 'tmp/backups/2020-08-11_12_00_00' }
    let(:keept_backup)   { 'tmp/backups/2020-08-22_12_00_00' }

    before do
      FileUtils.rm_rf(backup_path)
      FileUtils.mkpath(expired_backup)
      FileUtils.mkpath(keept_backup)
    end

    context 'with valid options' do
      before do
        described_class.call('tmp/backups', most_recent: 1)
      end

      it 'removes the expired backup' do
        expect(Pathname.new(expired_backup)).not_to exist
      end

      it 'keeps the unexpired backup' do
        expect(Pathname.new(keept_backup)).to exist
      end
    end

    context 'with an invalid format' do
      let(:opts) { { format: 'grimpfl', most_recent: 1 } }

      it 'raises an ArgumentError' do
        expect { described_class.call(backup_path, opts) }
          .to raise_error ArgumentError, 'unknown format "grimpfl"'
      end
    end

    context 'without any rules' do
      it 'raises a NoRulesError' do
        expect { described_class.call(backup_path, {}) }
          .to raise_error Expire::NoRulesError, 'Will not purge without rules'
      end
    end
  end

  describe '#format (private)' do
    context 'when the wanted format is "none"' do
      it 'returns an instance of Expire::NullFormat' do
        purge_service = described_class.new('path', format: 'none')
        expect(purge_service.send(:format))
          .to be_instance_of(Expire::NullFormat)
      end
    end

    context 'when the wanted format is nil' do
      it 'returns an instance of Expire::NullFormat' do
        purge_service = described_class.new('path', most_recent: 1)
        expect(purge_service.send(:format))
          .to be_instance_of(Expire::NullFormat)
      end
    end

    context 'when the wanted format is "enhanced"' do
      it 'returns an instance of Expire::EnhancedFormat' do
        purge_service = described_class.new('path', format: 'enhanced')
        expect(purge_service.send(:format))
          .to be_instance_of(Expire::EnhancedFormat)
      end
    end
  end
end
