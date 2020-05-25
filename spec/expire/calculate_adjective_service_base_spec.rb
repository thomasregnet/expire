# frozen_string_literal: true

require 'support/shared_examples_for_calculate_adjective_services'

RSpec.describe Expire::CalculateAdjectiveServiceBase do
  subject do
    described_class.new(
      adjective: :fake_adjective,
      backups:   :fake_backups,
      rules:     :rules
    )
  end

  it_behaves_like 'a calculate adjective service'

  describe '#noun' do
    let(:args) { { backups: :fake_backups, rules: :fake_rules } }

    context 'with a valid string as the adjective' do
      it 'returns the right noun' do
        base = described_class.new(args.merge(adjective: 'weekly'))
        expect(base.noun).to eq('week')
      end
    end

    context 'with a valid symbol as the adjective' do
      it 'returns the right noun' do
        base = described_class.new(args.merge(adjective: :daily))
        expect(base.noun).to eq('day')
      end
    end

    context 'with an invalid adjective' do
      it 'returns nil' do
        base = described_class.new(args.merge(adjective: 'badly'))
        expect(base.noun).to be_nil
      end
    end
  end
end
