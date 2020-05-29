# frozen_string_literal: true

RSpec.describe Expire::BackupList do
  describe '#backups' do
    context 'when initialized without any backups' do
      it 'returns an empty array' do
        expect(described_class.new.backups).to be_empty
      end
    end
  end

  describe '#one_per' do
    let(:backup_list) do
      described_class.new(
        [
          Expire::Backup.new(DateTime.new(1860, 5, 17, 12, 0,  0)),
          Expire::Backup.new(DateTime.new(1860, 5, 17, 12, 44, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 17, 12, 36, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 17, 12, 33, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 17, 13, 0,  0))
        ]
      )
    end

    context 'with hour' do
      it 'returns hourly backups' do
        expect(backup_list.one_per(:hour)).to contain_exactly(
          Expire::Backup.new(DateTime.new(1860, 5, 17, 12, 44, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 17, 13, 0,  0))
        )
      end
    end
  end

  describe '#to_audited_backup_list' do
    let(:backup_list) do
      described_class.new(
        [
          Expire::Backup.new(DateTime.new(1860, 5, 17, 12, 0,  0))
        ]
      )
    end

    it { should respond_to(:to_audited_backup_list) }

    it 'returns a BackupList' do
      expect(backup_list.to_audited_backup_list)
        .to be_instance_of(described_class)
    end

    it 'contains AuditedBackups' do
      expect(backup_list.to_audited_backup_list.first)
        .to be_instance_of(Expire::AuditedBackup)
    end
  end

  describe '#apply' do
    let(:backup_list) do
      described_class.new(
        [
          Expire::Backup.new(DateTime.new(1860, 5, 17, 12, 0,  0)),
          Expire::Backup.new(DateTime.new(1860, 5, 17, 12, 44, 0)),
          Expire::Backup.new(DateTime.new(1860, 5, 17, 12, 36, 0))
        ]
      )
    end

    it 'calls Expire::CalculateService' do
      allow(Expire::CalculateService).to receive(:call)

      backup_list.apply(:fake_rules)

      expect(Expire::CalculateService).to have_received(:call)
    end
  end
end
