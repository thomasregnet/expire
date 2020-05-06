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
    let(:backups) do
      described_class.new(
        [
          Expire::Backup.new(DateTime.new(1860, 5, 17, 12, 0,  0)),
          Expire::Backup.new(DateTime.new(1860, 5, 17, 12, 57, 0)),

          Expire::Backup.new(DateTime.new(1860, 5, 17, 13, 0,  0))
          # Expire::Backup.new(DateTime.new(1860, 5, 18, 12, 30, 0)),

          # Expire::Backup.new(DateTime.new(1860, 5, 18, 22, 0,  0)),
          # Expire::Backup.new(DateTime.new(1860, 5, 22, 12, 0,  0)),

          # Expire::Backup.new(DateTime.new(1860, 6, 17, 12, 0,  0)),
          # Expire::Backup.new(DateTime.new(1861, 5, 17, 12, 0,  0))
        ]
      )
    end

    context 'with hour' do
      it 'returns hourly backups' do
        expect(backups.one_per(:hour).length).to eq(2)
      end
    end
  end
end
