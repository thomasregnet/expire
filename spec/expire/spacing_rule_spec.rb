# frozen_string_literal: true

require 'support/shared_examples_for_rules'

RSpec.describe Expire::SpacingRule do
  subject do
    described_class.new(
      amount:  3,
      name:    'my_rule',
      spacing: 'hour'
    )
  end

  it_behaves_like 'a rule'

  describe 'spacing' do
    context 'with an invalid spacing' do
      it 'raises an ArgumentError' do
        args = { amount: 3, name: 'my_rule', spacing: 'February' }
        expect { described_class.new(args) }
          .to raise_error(
            ArgumentError, 'February is not a valid spacing'
          )
      end
    end

    context 'with valid spacings' do
      spacings = %w[hour hours day days week weeks month months year years]

      spacings.each do |spacing|
        it "accepts \"#{spacing}\" as spacing" do
          args = { amount: 3, name: 'my_rule', spacing: spacing }
          expect { described_class.new(args) }.not_to raise_error
        end
      end
    end
  end
end
