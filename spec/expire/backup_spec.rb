# frozen_string_literal: true

RSpec.describe Expire::Backup do
  describe '#same_hour?' do
    let(:backup) { described_class.new(DateTime.new(1860, 5, 17, 12, 0, 0)) }

    context 'when the hour is the same' do
      let(:other) { described_class.new(DateTime.new(1860, 5, 17, 12, 11, 22)) }
      it 'returns true' do
        expect(backup).to be_same_hour(other)
      end
    end

    context 'when the hour differs' do
      let(:other) { described_class.new(DateTime.new(1860, 5, 17, 13, 0, 0)) }
      it 'returns true' do
        expect(backup).not_to be_same_hour(other)
      end
    end

    context 'when the day differs' do
      let(:other) { described_class.new(DateTime.new(1860, 5, 22, 12, 0, 0)) }
      it 'returns true' do
        expect(backup).not_to be_same_hour(other)
      end
    end
  end
end
