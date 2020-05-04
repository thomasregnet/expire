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
      it 'returns false' do
        expect(backup).not_to be_same_hour(other)
      end
    end

    context 'when the day differs' do
      let(:other) { described_class.new(DateTime.new(1860, 5, 22, 12, 0, 0)) }
      it 'returns false' do
        expect(backup).not_to be_same_hour(other)
      end
    end
  end

  describe '#same_day?' do
    let(:backup) { described_class.new(DateTime.new(1860, 5, 17, 12, 0, 0)) }

    context 'when the day is the same' do
      let(:other) { described_class.new(DateTime.new(1860, 5, 17, 23, 11, 22)) }
      it 'returns true' do
        expect(backup).to be_same_day(other)
      end
    end

    context 'when the day differs' do
      let(:other) { described_class.new(DateTime.new(1860, 5, 18, 13, 0, 0)) }
      it 'returns false' do
        expect(backup).not_to be_same_day(other)
      end
    end

    context 'when the month differs' do
      let(:other) { described_class.new(DateTime.new(1860, 4, 22, 12, 0, 0)) }
      it 'returns false' do
        expect(backup).not_to be_same_day(other)
      end
    end
  end

  describe '#same_week?' do
    let(:backup) { described_class.new(DateTime.new(1860, 5, 17, 12, 0, 0)) }

    context 'when the week is the same' do
      let(:other) { described_class.new(DateTime.new(1860, 5, 15, 12, 0, 0)) }
      it 'returns true' do
        expect(backup).to be_same_week(other)
      end
    end

    context 'when the week differs' do
      let(:other) { described_class.new(DateTime.new(1860, 5, 22, 13, 0, 0)) }
      it 'returns false' do
        expect(backup).not_to be_same_week(other)
      end
    end

    context 'when the month differs' do
      let(:other) { described_class.new(DateTime.new(1860, 4, 22, 12, 0, 0)) }
      it 'returns false' do
        expect(backup).not_to be_same_week(other)
      end
    end
  end

  describe '#same_month?' do
    let(:backup) { described_class.new(DateTime.new(1860, 5, 17, 12, 0, 0)) }

    context 'when the month is the same' do
      let(:other) { described_class.new(DateTime.new(1860, 5, 1, 12, 0, 0)) }
      it 'returns true' do
        expect(backup).to be_same_month(other)
      end
    end

    context 'when the month differs' do
      let(:other) { described_class.new(DateTime.new(1860, 3, 17, 13, 0, 0)) }
      it 'returns false' do
        expect(backup).not_to be_same_month(other)
      end
    end

    context 'when the year differs' do
      let(:other) { described_class.new(DateTime.new(1859, 5, 17, 12, 0, 0)) }
      it 'returns false' do
        expect(backup).not_to be_same_week(other)
      end
    end
  end

  describe '#same_year?' do
    let(:backup) { described_class.new(DateTime.new(1860, 5, 17, 12, 0, 0)) }

    context 'when the year is the same' do
      let(:other) { described_class.new(DateTime.new(1860, 2, 15, 1, 10, 30)) }
      it 'returns true' do
        expect(backup).to be_same_year(other)
      end
    end

    context 'when the year differs' do
      let(:other) { described_class.new(DateTime.new(1859, 5, 17, 12, 0, 0)) }

      it 'returns false' do
        expect(backup).not_to be_same_year(other)
      end
    end
  end
end
