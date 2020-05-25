# frozen_string_literal: true

RSpec.describe Expire::AuditedBackup do
  subject { described_class.new(:fake_backup) }

  it { should respond_to :backup }
  it { should respond_to :reasons_to_keep }

  describe '#expired?' do
    let(:audited) { described_class.new(:fake_backup) }

    context 'with reasons_to_keep' do
      before { audited.add_reason_to_keep('want to keep') }

      it 'returns false' do
        expect(audited).not_to be_expired
      end
    end

    context 'without reasons_to_keep' do
      it 'returns true' do
        expect(audited).to be_expired
      end
    end
  end

  describe '#keep?' do
    let(:audited) { described_class.new(:fake_backup) }

    context 'with reasons_to_keep' do
      before { audited.add_reason_to_keep('want to keep') }

      it 'returns true' do
        expect(audited).to be_keep
      end
    end

    context 'without reasons_to_keep' do
      it 'returns false' do
        expect(audited).not_to be_keep
      end
    end
  end
end
