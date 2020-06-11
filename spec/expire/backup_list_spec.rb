# frozen_string_literal: true

RSpec.describe Expire::BackupList do
  describe '#backups' do
    context 'when initialized without any backups' do
      it 'returns an empty array' do
        expect(described_class.new.backups).to be_empty
      end
    end
  end

  describe '#latest'

  describe '#latest_one' do
    let(:backup_list) do
      described_class.new(
        [
          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 12, 0, 0),
            path:     :fake_path
          ),

          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 12, 44, 0),
            path:     :fake_path
          )
        ]
      )
    end

    it 'returns the latest backup' do
      # Since we are working with dates without
      # time zone we omit the +-\d\d:\d\d part
      expect(backup_list.latest_one.to_s).to match(/\A1860-05-17T12:44/)
    end
  end

  describe '#one_per' do
    let(:backup_list) do
      described_class.new(
        [
          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 12, 0, 0),
            path:     :fake_path
          ),

          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 12, 44, 0),
            path:     :fake_path
          ),
          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 12, 36, 0),
            path:     :fake_path
          ),

          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 12, 33, 0),
            path:     :fake_path
          ),

          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 13, 0, 0),
            path:     :fake_path
          )
        ]
      )
    end

    context 'with hour' do
      it 'returns hourly backups' do
        expect(backup_list.one_per(:hour)).to contain_exactly(
          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 12, 44, 0),
            path:     :fake_path
          ),
          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 13, 0, 0),
            path:     :fake_path
          )
        )
      end
    end
  end

  describe '#to_audited_backup_list' do
    let(:backup_list) do
      described_class.new(
        [
          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 12, 0, 0),
            path:     :fake_path
          )
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
          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 12, 0, 0),
            path:     :fake_path
          ),
          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 12, 44, 0),
            path:     :fake_path
          ),
          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 12, 36, 0),
            path:     :fake_path
          )
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
