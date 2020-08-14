# frozen_string_literal: true

RSpec.describe 'RefineAllAndNone' do
  using Expire::RefineAllAndNone

  context 'when 1' do
    let(:value) { 1 }

    describe '#all?' do
      it 'is not true' do
        expect(value.all?).not_to be true
      end
    end

    describe '#none?' do
      it 'is not true' do
        expect(value.none?).not_to be true
      end
    end
  end

  context 'when 0' do
    let(:value) { 0 }

    describe '#all?' do
      it 'is not true' do
        expect(value.all?).not_to be true
      end
    end

    describe '#none?' do
      it 'is true' do
        expect(value.none?).to be true
      end
    end
  end

  context 'when -1' do
    let(:value) { -1 }

    describe '#all?' do
      it 'is true' do
        expect(value.all?).to be true
      end
    end

    describe '#none?' do
      it 'is not true' do
        expect(value.none?).not_to be true
      end
    end
  end

  ######################################
  context 'when "1"' do
    let(:value) { '1' }

    describe '#all?' do
      it 'is not true' do
        expect(value.all?).not_to be true
      end
    end

    describe '#none?' do
      it 'is not true' do
        expect(value.none?).not_to be true
      end
    end
  end

  context 'when "0"' do
    let(:value) { '0' }

    describe '#all?' do
      it 'is not true' do
        expect(value.all?).not_to be true
      end
    end

    describe '#none?' do
      it 'is true' do
        expect(value.none?).to be true
      end
    end
  end

  context 'when "-1"' do
    let(:value) { '-1' }

    describe '#all?' do
      it 'is true' do
        expect(value.all?).to be true
      end
    end

    describe '#none?' do
      it 'is not true' do
        expect(value.none?).not_to be true
      end
    end
  end
end
