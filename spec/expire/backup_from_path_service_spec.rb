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

    context 'with to much numbers' do
      let(:service) { described_class.new(path: '/backups/2021-01-19T20:21:22extra123, by: :path') }

      it 'raises an InvalidPathError' do
        expect { service.call }.to raise_error(Expire::InvalidPathError, /2021-01-19T20:21:22extra123/)
      end
    end

    context 'without enough numbers' do
      let(:service) { described_class.new(path: '/backups/2021-01-19T20, by: :path') }

      it 'raises an InvalidPathError' do
        expect { service.call }.to raise_error(Expire::InvalidPathError, /2021-01-19T20/)
      end
    end

    context 'with 13 numbers' do
      let(:service) { described_class.new(path: '/backups/1234567890123', by: :path) }

      it 'raises an InvalidPathError' do
        expect { service.call }.to raise_error(Expire::InvalidPathError, /1234567890123/)
      end
    end

    context 'without any numbers' do
      let(:service) { described_class.new(path: '/backups/hello_world', by: :path) }

      it 'raises an InvalidPathError' do
        expect { service.call }.to raise_error(Expire::InvalidPathError, /hello_world/)
      end
    end
  end
end
