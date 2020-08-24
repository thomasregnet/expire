# frozen_string_literal: true

RSpec.shared_examples 'a keep all rule' do
  describe '.from_value' do
    context 'with "all" as value' do
      it 'has an amount of -1' do
        rule = described_class.from_value('all')
        expect(rule.amount).to eq(-1)
      end
    end
  end

  describe '#numerus_backp' do
    context 'with an amount of -1' do
      it 'returns "backups"' do
        rule = described_class.new(amount: -1)
        expect(rule.numerus_backup).to eq('backups')
      end
    end
  end

  describe '#reason_to_keep' do
    context 'with an amount of 5' do
      it 'keeps 1 backup' do
        rule = described_class.new(amount: 5)
        expect(rule.send(:reason_to_keep)).to match(/\Akeep 5 \w+ backups\z/)
      end
    end

    context 'with an amount of 1' do
      it 'keeps 1 backup' do
        rule = described_class.new(amount: 1)
        expect(rule.send(:reason_to_keep)).to match(/\Akeep 1 \w+ backup\z/)
      end
    end

    context 'with an amount of -1' do
      it 'keeps all backups' do
        rule = described_class.new(amount: -1)
        expect(rule.send(:reason_to_keep)).to match(/\Akeep all \w+ backups\z/)
      end
    end
  end
end
