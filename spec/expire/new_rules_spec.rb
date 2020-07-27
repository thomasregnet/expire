# frozen_string_literal: true

RSpec.describe Expire::NewRules do
  describe '.new' do
    context 'with an unknown rule' do
      it 'raises an Expire::UnknownRuleError' do
        expect { described_class.new(bad_rule: 666) }
          .to raise_error(
            Expire::UnknownRuleError,
            'unknown rule name "bad_rule"'
          )
      end
    end

    context 'with valid rules' do
      let(:rules) do
        {
          most_recent: 3
        }
      end

      it 'does not raise an error' do
        expect { described_class.new(rules) }.not_to raise_error
      end
    end
  end
end
