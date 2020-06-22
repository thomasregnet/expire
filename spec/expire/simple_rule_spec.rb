# frozen_string_literal: true

require 'support/shared_examples_for_rules'

RSpec.describe Expire::SimpleRule do
  subject do
    described_class.new(amount: 1, name: 'my_rule')
  end

  it_behaves_like 'a rule'

  describe 'amount' do
    context 'with an integer as value' do
      it 'returns that integer' do
        rule = described_class.new(amount: 3, name: 'my_rule')
        expect(rule.amount).to eq(3)
      end
    end
  end

  describe '.from_string' do
    context 'with a string representing a positive integer' do
      let(:rule) { described_class.from_string(' 123 ', name: 'my_rule') }

      it 'sets the right amount' do
        expect(rule.amount).to eq(123)
      end

      it 'sets the name' do
        expect(rule.name).to eq('my_rule')
      end
    end

    context 'with the string "ALL"' do
      let(:rule) { described_class.from_string(' ALL ', name: 'my_rule') }

      it 'sets the amount to -1' do
        expect(rule.amount).to eq(-1)
      end
    end

    context 'with the string "NONE"' do
      let(:rule) { described_class.from_string(' NONE ', name: 'my_rule') }

      it 'sets the amount to 0' do
        expect(rule.amount).to eq(0)
      end
    end

    context 'with the string "Grimpflwurg"' do
      it 'raises an ArgumentError' do
        expect { described_class.from_string('Grimpflwurg', name: 'my_rule') }
          .to raise_error(
            ArgumentError,
            'Grimpflwurg is not a valid value for my_rule'
          )
      end
    end
  end
end
