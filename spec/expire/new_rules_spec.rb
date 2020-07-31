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
          most_recent: 3,
          hourly:      3,
          daily:       3,
          weekly:      3,
          monthly:     3,
          yearly:      3
        }
      end

      it 'does not raise an error' do
        expect { described_class.new(rules) }.not_to raise_error
      end
    end
  end

  describe '#apply' do
    let(:rules) { described_class.new }
    let(:first_rule) { instance_double('Expire::HourlyRule') }
    let(:second_rule) { instance_double('Expire::DailyRule') }

    before do
      allow(rules).to receive(:rules).and_return([second_rule, first_rule])
      allow(first_rule).to receive(:rank).and_return(1)
      allow(second_rule).to receive(:rank).and_return(2)

      allow(first_rule).to receive(:apply)
      allow(second_rule).to receive(:apply)
    end

    it 'calls #apply on the first rule' do
      rules.apply
      expect(first_rule).to have_received(:apply)
    end

    it 'calls #apply on the second rule' do
      rules.apply
      expect(second_rule).to have_received(:apply)
    end
  end
end
