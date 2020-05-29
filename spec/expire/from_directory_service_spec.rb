# frozen_string_literal: true

require 'fileutils'

RSpec.describe Expire::FromDirectoryService do
  context 'with a valid backup directory' do
    let(:backup_list) do
      backup_path = Pathname.new('tmp/backups')

      FileUtils.rm_rf(backup_path) if backup_path.exist?

      %w[2020-04-29-09-12 2020-05-28-09-15].each do |backup_date|
        FileUtils.mkpath("#{backup_path}/#{backup_date}")
      end

      described_class.call(backup_path.to_s)
    end

    it 'returns a BackupList' do
      expect(backup_list).to be_instance_of Expire::BackupList
    end

    it 'has set the expected amount of backups' do
      expect(backup_list.backups.length).to eq(2)
    end

    it 'has added the expected backups' do
      expect(backup_list.backups)
        .to contain_exactly(
          Expire::Backup.new(DateTime.new(2020, 5, 28, 9, 15)),
          Expire::Backup.new(DateTime.new(2020, 4, 29, 9, 12))
        )
    end
  end
end
