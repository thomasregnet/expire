# frozen_string_literal: true

RSpec.describe Expire::BackupFromPathService do
  describe '#call by: :path' do
    context 'with path "/path/to/backups/20210102T0304"' do
      let(:service) { described_class.new(path: Pathname.new('path/to/backups/20210102T0304'), by: :path) }

      it 'returns an instance of Expire::Backup' do
        expect(service.call).to be_instance_of(Expire::Backup)
      end

      it 'returns a Backup with the expected datetime' do
        expect(service.call.datetime).to eq(DateTime.new(2021, 1, 2, 3, 4))
      end
    end
  end
end
