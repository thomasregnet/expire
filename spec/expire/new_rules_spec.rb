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
    let(:backups) { instance_double('Expire::Backups') }

    context 'when backups are empty' do
      let(:most_recent_rule) { instance_double('Expire::MostRecentRule') }
      let(:rules) { described_class.new(most_recent: most_recent_rule) }

      before {
        allow(backups).to receive(:empty?).and_return(true)
        allow(most_recent_rule).to receive(:apply)
      }

      it 'does not call #apply on the rules' do
        rules.apply(backups)
        expect(most_recent_rule).not_to have_received(:apply)
      end
    end

    context 'with the most_recent rule' do
      let(:most_recent_rule) { instance_double('Expire::MostRecentRule') }
      let(:rules) { described_class.new(most_recent: most_recent_rule) }

      before do
        allow(backups).to receive(:empty?).and_return(false)
        allow(most_recent_rule).to receive(:apply)
      end

      it 'calls apply on the most_recent rule' do
        rules.apply(backups)
        expect(most_recent_rule).to have_received(:apply).with(backups)
      end
    end

    context 'with one_per_spacing rules' do
      let(:one_per_hour_rule) { instance_double('Expire::SimpleRule') }
      let(:one_per_day_rule) { instance_double('Expire::SimpleRule') }
      let(:one_per_week_rule) { instance_double('Expire::SimpleRule') }
      let(:one_per_month_rule) { instance_double('Expire::SimpleRule') }
      let(:one_per_year_rule) { instance_double('Expire::SimpleRule') }
      # let(:backups) { [] }
      let(:backups) { instance_double('Expire::Backups') }

      let(:rules) do
        described_class.new(
          one_per_hour:  one_per_hour_rule,
          one_per_day:   one_per_day_rule,
          one_per_week:  one_per_week_rule,
          one_per_month: one_per_month_rule,
          one_per_year:  one_per_year_rule
        )
      end

      before do
        allow(backups).to receive(:empty?).and_return(false)

        allow(one_per_hour_rule).to receive(:apply)
        allow(one_per_day_rule).to receive(:apply)
        allow(one_per_week_rule).to receive(:apply)
        allow(one_per_month_rule).to receive(:apply)
        allow(one_per_year_rule).to receive(:apply)

        rules.apply(backups)
      end

      it 'calls apply on the one_per_hour instance' do
        expect(one_per_hour_rule).to have_received(:apply).with(backups)
      end

      it 'calls apply on the one_per_day instance' do
        expect(one_per_day_rule).to have_received(:apply).with(backups)
      end

      it 'calls apply on the one_per_week instance' do
        expect(one_per_week_rule).to have_received(:apply).with(backups)
      end

      it 'calls apply on the one_per_month instance' do
        expect(one_per_month_rule).to have_received(:apply).with(backups)
      end

      it 'calls apply on the one_per_year instance' do
        expect(one_per_year_rule).to have_received(:apply).with(backups)
      end
    end

    context 'with one_per_spacing_for rules' do
      let(:one_per_hour_for_rule) do
        instance_double('Expire::OnePerSpacingForRule')
      end

      let(:one_per_day_for_rule) do
        instance_double('Expire::OnePerSpacingForRule')
      end

      let(:one_per_week_for_rule) do
        instance_double('Expire::OnePerSpacingForRule')
      end

      let(:one_per_month_for_rule) do
        instance_double('Expire::OnePerSpacingForRule')
      end

      let(:one_per_year_for_rule) do
        instance_double('Expire::OnePerSpacingForRule')
      end

      let(:reference_time) { DateTime.now }

      let(:rules) do
        described_class.new(
          one_per_hour_for:  one_per_hour_for_rule,
          one_per_day_for:   one_per_day_for_rule,
          one_per_week_for:  one_per_week_for_rule,
          one_per_month_for: one_per_month_for_rule,
          one_per_year_for:  one_per_year_for_rule
        )
      end

      before do
        allow(backups).to receive(:empty?).and_return(false)

        allow(one_per_hour_for_rule).to receive(:apply)
        allow(one_per_day_for_rule).to receive(:apply)
        allow(one_per_week_for_rule).to receive(:apply)
        allow(one_per_month_for_rule).to receive(:apply)
        allow(one_per_year_for_rule).to receive(:apply)

        rules.apply(backups)
      end

      it 'calls apply on the one_per_hour instance' do
        expect(one_per_hour_for_rule).to have_received(:apply).with(backups)
      end

      it 'calls apply on the one_per_day instance' do
        expect(one_per_day_for_rule).to have_received(:apply).with(backups)
      end

      it 'calls apply on the one_per_week instance' do
        expect(one_per_week_for_rule).to have_received(:apply).with(backups)
      end

      it 'calls apply on the one_per_month instance' do
        expect(one_per_month_for_rule).to have_received(:apply).with(backups)
      end

      it 'calls apply on the one_per_year instance' do
        expect(one_per_year_for_rule).to have_received(:apply).with(backups)
      end
    end

    context 'with one_per_spacing rules' do
      let(:one_per_hour_rule) { instance_double('Expire::SimpleRule') }
      let(:one_per_day_rule) { instance_double('Expire::SimpleRule') }
      let(:one_per_week_rule) { instance_double('Expire::SimpleRule') }
      let(:one_per_month_rule) { instance_double('Expire::SimpleRule') }
      let(:one_per_year_rule) { instance_double('Expire::SimpleRule') }

      let(:rules) do
        described_class.new(
          one_per_hour:  one_per_hour_rule,
          one_per_day:   one_per_day_rule,
          one_per_week:  one_per_week_rule,
          one_per_month: one_per_month_rule,
          one_per_year:  one_per_year_rule
        )
      end

      before do
        allow(backups).to receive(:empty?).and_return(false)

        allow(one_per_hour_rule).to receive(:apply)
        allow(one_per_day_rule).to receive(:apply)
        allow(one_per_week_rule).to receive(:apply)
        allow(one_per_month_rule).to receive(:apply)
        allow(one_per_year_rule).to receive(:apply)

        rules.apply(backups)
      end

      it 'calls apply on the one_per_hour instance' do
        expect(one_per_hour_rule).to have_received(:apply).with(backups)
      end

      it 'calls apply on the one_per_day instance' do
        expect(one_per_day_rule).to have_received(:apply).with(backups)
      end

      it 'calls apply on the one_per_week instance' do
        expect(one_per_week_rule).to have_received(:apply).with(backups)
      end

      it 'calls apply on the one_per_month instance' do
        expect(one_per_month_rule).to have_received(:apply).with(backups)
      end

      it 'calls apply on the one_per_year instance' do
        expect(one_per_year_rule).to have_received(:apply).with(backups)
      end
    end

    context 'with from_now_one_per_spacing_for rules' do
      let(:from_now_one_per_hour_for_rule) do
        instance_double('Expire::OnePerSpacingForRule')
      end

      let(:from_now_one_per_day_for_rule) do
        instance_double('Expire::OnePerSpacingForRule')
      end

      let(:from_now_one_per_week_for_rule) do
        instance_double('Expire::OnePerSpacingForRule')
      end

      let(:from_now_one_per_month_for_rule) do
        instance_double('Expire::OnePerSpacingForRule')
      end

      let(:from_now_one_per_year_for_rule) do
        instance_double('Expire::OnePerSpacingForRule')
      end

      let(:reference_time) { DateTime.now }

      let(:rules) do
        described_class.new(
          from_now_one_per_hour_for:  from_now_one_per_hour_for_rule,
          from_now_one_per_day_for:   from_now_one_per_day_for_rule,
          from_now_one_per_week_for:  from_now_one_per_week_for_rule,
          from_now_one_per_month_for: from_now_one_per_month_for_rule,
          from_now_one_per_year_for:  from_now_one_per_year_for_rule
        )
      end

      before do
        allow(backups).to receive(:empty?).and_return(false)

        allow(from_now_one_per_hour_for_rule).to receive(:apply)
        allow(from_now_one_per_day_for_rule).to receive(:apply)
        allow(from_now_one_per_week_for_rule).to receive(:apply)
        allow(from_now_one_per_month_for_rule).to receive(:apply)
        allow(from_now_one_per_year_for_rule).to receive(:apply)

        rules.apply(backups)
      end

      it 'calls apply on the from_now_one_per_hour instance' do
        expect(from_now_one_per_hour_for_rule)
          .to have_received(:apply).with(backups, instance_of(DateTime))
      end

      it 'calls apply on the from_now_one_per_day instance' do
        expect(from_now_one_per_day_for_rule)
          .to have_received(:apply).with(backups, instance_of(DateTime))
      end

      it 'calls apply on the from_now_one_per_week instance' do
        expect(from_now_one_per_week_for_rule)
          .to have_received(:apply).with(backups, instance_of(DateTime))
      end

      it 'calls apply on the from_now_one_per_month instance' do
        expect(from_now_one_per_month_for_rule)
          .to have_received(:apply).with(backups, instance_of(DateTime))
      end

      it 'calls apply on the from_now_one_per_year instance' do
        expect(from_now_one_per_year_for_rule)
          .to have_received(:apply).with(backups, instance_of(DateTime))
      end
    end
  end
end
