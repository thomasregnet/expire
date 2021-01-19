# frozen_string_literal: true

RSpec.describe Expire::BackupFromPathService do
  describe '#call by: :path' do
    %w[
      /path/to/backups/2021-01-02T03:04
      /1/22/345/20210102T0304
      /1/22/345/20210102T03:04:59
    ].each do |path|
      context "with path #{path}" do
        let(:service) { described_class.new(path: path, by: :path) }

        it 'returns an instance of Expire::Backup' do
          expect(service.call).to be_instance_of(Expire::Backup)
        end

        it 'returns a Backup with the expected datetime' do
          expect(service.call.datetime).to eq(DateTime.new(2021, 1, 2, 3, 4))
        end
      end
    end
  end
end
