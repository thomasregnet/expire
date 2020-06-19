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

    context 'with a string that looks like an integer as value' do
      it 'returns that integer' do
        rule = described_class.new(amount: '3_000', name: 'my_rule')
        expect(rule.amount).to eq(3_000)
      end
    end

    context 'with nil as value' do
      it 'raises an ArgumentError' do
        expect { described_class.new(amount: nil, name: 'my_rule') }
          .to raise_error ArgumentError, 'nil is not a valid value for my_rule'
      end
    end

    context 'with an invalid value' do
      it 'raises an ArgumentError' do
        expect { described_class.new(amount: 'bad', name: 'my_rule') }
          .to raise_error ArgumentError, 'bad is not a valid value for my_rule'
      end
    end
  end
end
