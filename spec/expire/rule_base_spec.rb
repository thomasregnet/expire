# frozen_string_literal: true

require 'support/shared_examples_for_rules'

RSpec.describe Expire::RuleBase do
  subject do
    described_class.new(amount: 1)
  end

  # it_behaves_like 'a rule'

  describe 'amount' do
    context 'with an integer as value' do
      it 'returns that integer' do
        rule = described_class.new(amount: 3)
        expect(rule.amount).to eq(3)
      end
    end
  end

  describe '.from_string' do
    context 'with a string representing a positive integer' do
      let(:rule) { described_class.from_string(' 123 ') }

      it 'sets the right amount' do
        expect(rule.amount).to eq(123)
      end
    end

    context 'with the string "ALL"' do
      let(:rule) { described_class.from_string(' ALL ') }

      it 'sets the amount to -1' do
        expect(rule.amount).to eq(-1)
      end
    end

    context 'with the string "NONE"' do
      let(:rule) { described_class.from_string(' NONE ') }

      it 'sets the amount to 0' do
        expect(rule.amount).to eq(0)
      end
    end

    context 'with the string "Grimpflwurg"' do
      it 'raises an ArgumentError' do
        expect { described_class.from_string('Grimpflwurg') }
          .to raise_error(ArgumentError, 'Grimpflwurg is not a valid amount')
      end
    end
  end

  describe '#conditionally_pluralize' do
    context 'with an amount of 1' do
      let(:rule) { described_class.new(amount: 1) }

      it 'returns the singular' do
        expect(rule.conditionally_pluralize('backups')).to eq('backup')
      end
    end

    context 'with an amount greater than 1' do
      let(:rule) { described_class.new(amount: 2) }

      it 'returns the plural' do
        expect(rule.conditionally_pluralize('backup')).to eq('backups')
      end
    end
  end
end
