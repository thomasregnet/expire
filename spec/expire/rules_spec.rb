# frozen_string_literal: true

RSpec.describe Expire::Rules do
  context 'with rule and non rule options' do
    describe '.from_options' do
      let(:options) do
        {
          no_rule_at_all:           'some value',
          most_recent:              3,
          most_recent_for:          '3 days',
          from_now_most_recent_for: '3 days',
          hourly:                   3,
          daily:                    3,
          weekly:                   3,
          monthly:                  3,
          yearly:                   3,
          hourly_for:               '3 years',
          daily_for:                '3 years',
          weekly_for:               '3 years',
          monthly_for:              '3 years',
          yearly_for:               '3 years',
          from_now_hourly_for:      '3 years',
          from_now_daily_for:       '3 years',
          from_now_weekly_for:      '3 years',
          from_now_monthly_for:     '3 years',
          from_now_yearly_for:      '3 years'
        }
      end

      it 'returns a Expire::Rules instance' do
        expect(described_class.from_options(options))
          .to be_instance_of(described_class)
      end
    end
  end

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
          most_recent:              3,
          most_recent_for:          '3 days',
          from_now_most_recent_for: '3 days',
          hourly:                   3,
          daily:                    3,
          weekly:                   3,
          monthly:                  3,
          yearly:                   3,
          hourly_for:               '3 years',
          daily_for:                '3 years',
          weekly_for:               '3 years',
          monthly_for:              '3 years',
          yearly_for:               '3 years',
          from_now_hourly_for:      '3 years',
          from_now_daily_for:       '3 years',
          from_now_weekly_for:      '3 years',
          from_now_monthly_for:     '3 years',
          from_now_yearly_for:      '3 years'
        }
      end

      it 'does not raise an error' do
        expect { described_class.new(rules) }.not_to raise_error
      end
    end
  end

  describe '#apply' do
    let(:backups) { instance_double 'Expire::Backups' }
    let(:rules) { described_class.new }
    let(:first_rule) { Expire::HourlyRule.from_value('none') }
    let(:second_rule) { Expire::DailyRule.from_value('none') }

    before do
      allow(rules).to receive(:rules).and_return([second_rule, first_rule])
      allow(first_rule).to receive(:rank).and_return(1)
      allow(second_rule).to receive(:rank).and_return(2)

      allow(first_rule).to receive(:apply)
      allow(second_rule).to receive(:apply)
    end

    it 'calls #apply on the first rule' do
      rules.apply(backups, :dummy_reference_datetime)
      expect(first_rule).to have_received(:apply)
    end

    it 'calls #apply on the second rule' do
      rules.apply(backups, :dummy_reference_datetime)
      expect(second_rule).to have_received(:apply)
    end
  end

  describe '#count' do
    let(:rules) { described_class.new(daily: 1, weekly: 3) }

    it 'returns the number of rules' do
      expect(rules.count).to eq(2)
    end
  end

  describe '#merge' do
    let(:merged) do
      described_class.new(most_recent: 3, weekly: 3)
                     .merge(described_class.new(weekly: 5, yearly: 7))
    end

    it 'returns the expected count of rules' do
      expect(merged.count).to eq(3)
    end

    it 'keeps rules that are not contained in the prior rules' do
      expect(merged.to_h[:most_recent].amount).to eq(3)
    end

    it 'prefers the rules in the prior rules' do
      expect(merged.to_h[:weekly].amount).to eq(5)
    end

    it 'adds rules that are only contained in the prior rules' do
      expect(merged.to_h[:yearly].amount).to eq(7)
    end
  end
end
