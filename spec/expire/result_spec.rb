# frozen_string_literal: true

RSpec.describe Expire::Result do
  let(:result) do
    described_class.new(
      [
        instance_double('AuditedBackup', 'expired?' => true, 'keep?' => false),
        instance_double('AuditedBackup', 'expired?' => false, 'keep?' => true),
        instance_double('AuditedBackup', 'expired?' => true, 'keep?' => false)
      ]
    )
  end

  describe '#expired' do
    it 'returns the expired backups' do
      expect(result.expired.length).to eq(2)
    end
  end

  describe '#keep' do
    it 'returns the backups to be kept' do
      expect(result.keep.length).to eq(1)
    end
  end

  describe '#expired_count' do
    it 'returns the expired backups' do
      expect(result.expired_count).to eq(2)
    end
  end

  describe '#keep_count' do
    it 'returns the backups to be kept' do
      expect(result.keep_count).to eq(1)
    end
  end
end
