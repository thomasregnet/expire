# frozen_string_literal: true

RSpec.describe Expire::Backups do
  describe '#backups' do
    context 'when initialized without any backups' do
      it 'returns an empty array' do
        expect(described_class.new.backups).to be_empty
      end
    end
  end

  describe '#latest' do
    let(:backups) do
      described_class.new(
        [
          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 12, 0, 0),
            path:     :oldest
          ),

          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 12, 44, 0),
            path:     :latest
          ),
          Expire::Backup.new(
            datetime: DateTime.new(1860, 5, 17, 12, 36, 0),
            path:     :middle
          )
        ]
      )
    end

    context 'without parameter' do
      it "returns an instance of #{described_class}" do
        expect(backups.latest).to be_instance_of(described_class)
      end

      it 'returns one backup' do
        expect(backups.latest.length).to eq(1)
      end

      it 'returns the latest backup' do
        expect(backups.latest.last.path).to eq(:latest)
      end
    end

    context 'with 2 as parameter' do
      it 'returns an Array with one element' do
        expect(backups.latest(2).length).to eq(2)
      end

      it 'returns the latest backup' do
        paths = backups.latest(2).map(&:path)
        expect(paths).to eq(%i[latest middle])
      end
    end

    context 'with a parameter that exceeds the amount of backups' do
      it 'returns an Array with the backups' do
        expect(backups.latest(99).length).to eq(3)
      end
    end
  end

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

  describe '#oldest_one' do
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
      expect(backup_list.oldest_one.to_s).to match(/\A1860-05-17T12:00/)
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

  describe 'after expire' do
    let(:expired_one) { instance_double('Expire::NewBackup') }
    let(:expired_two) { instance_double('Expire::NewBackup') }
    let(:kept_one) { instance_double('Expire::NewBackup') }

    let(:backups) do
      described_class.new([expired_one, expired_two, kept_one])
    end

    describe '#expired' do
      it 'returns the expired backups' do
        allow(expired_one).to receive(:expired?).and_return(true)
        allow(expired_two).to receive(:expired?).and_return(true)
        allow(kept_one).to receive(:expired?).and_return(false)

        expect(backups.expired.length).to eq(2)
      end
    end

    describe '#keep' do
      it 'returns the backups to be kept' do
        allow(expired_one).to receive(:keep?).and_return(false)
        allow(expired_two).to receive(:keep?).and_return(false)
        allow(kept_one).to receive(:keep?).and_return(true)

        expect(backups.keep.length).to eq(1)
      end
    end

    describe '#keep_count' do
      it 'returns the backups to be kept' do
        allow(expired_one).to receive(:keep?).and_return(false)
        allow(expired_two).to receive(:keep?).and_return(false)
        allow(kept_one).to receive(:keep?).and_return(true)

        expect(backups.keep_count).to eq(1)
      end
    end

    describe '#purge' do
      # No verifying double for backup because #id is delegated
      let(:backup) { instance_double('Expire::NewBackup') }
      let(:format) { instance_double('Expire::NullFormat') }
      let(:result) { described_class.new([backup]) }

      before do
        allow(format).to receive(:before_purge)
        allow(format).to receive(:after_purge)
        allow(backup).to receive(:path).and_return(:fake_path)
        allow(backup).to receive(:expired?).and_return(true)
        allow(FileUtils).to receive(:rm_rf)
      end

      it 'calls FileUtils.rm_rf' do
        result.purge(format)

        expect(FileUtils).to have_received(:rm_rf)
      end
    end
  end
end
