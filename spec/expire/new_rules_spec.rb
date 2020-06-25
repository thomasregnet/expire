# frozen_string_literal: true

RSpec.describe Expire::NewRules do
  it { should respond_to(:one_per_hour) }
  it { should respond_to(:one_per_day) }
  it { should respond_to(:one_per_week) }
  it { should respond_to(:one_per_month) }
  it { should respond_to(:one_per_year) }

  it { should respond_to(:one_per_hour_for) }
  it { should respond_to(:one_per_day_for) }
  it { should respond_to(:one_per_week_for) }
  it { should respond_to(:one_per_month_for) }
  it { should respond_to(:one_per_year_for) }

  it { should respond_to(:from_now_one_per_hour_for) }
  it { should respond_to(:from_now_one_per_day_for) }
  it { should respond_to(:from_now_one_per_week_for) }
  it { should respond_to(:from_now_one_per_month_for) }
  it { should respond_to(:from_now_one_per_year_for) }

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
  end

  # describe 'on_per_unit rules' do
  #   let(:rules) do
  #     described_class.new(one_per_week: 5)
  #   end

  #   it 'returns a SimpleRule' do
  #     expect(rules.one_per_week).to be_instance_of(Expire::SimpleRule)
  #   end
  # end

  describe '.from_string_values' do
    context 'without any rules' do
      it 'returns a rules object' do
        expect(described_class.from_string_values({}))
          .to be_instance_of(described_class)
      end
    end

    context 'with a one_per_spacing-rule' do
      let(:rules) do
        described_class.from_string_values(one_per_week: '6')
      end

      it 'sets the rule' do
        expect(rules.one_per_week).to be_instance_of(Expire::RuleBase)
      end

      it 'sets the rule with the right amount' do
        expect(rules.one_per_week.amount).to eq(6)
      end
    end

    context 'with an unknown rule' do
      it 'raises an Expire::UnknownRuleError' do
        expect { described_class.from_string_values(evil_rule: '666') }
          .to raise_error(
            Expire::UnknownRuleError,
            'unknown rule name "evil_rule"'
          )
      end
    end
  end

  describe '#apply' do
    let(:one_per_hour) { instance_double('Expire::SimpleRule') }
    let(:rules) { described_class.new(one_per_hour: one_per_hour) }
    let(:backups) { [] }

    before do
      allow(one_per_hour).to receive(:apply)

      rules.apply(backups)
    end

    it 'calls apply on its rules' do
      expect(one_per_hour).to have_received(:apply)
    end
  end
end
