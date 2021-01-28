# frozen_string_literal: true

RSpec.describe Expire::RuleList do
  describe '.class_names' do
    let(:expected) do
      %w[
        Expire::KeepMostRecentRule
        Expire::KeepMostRecentForRule
        Expire::KeepFromNowMostRecentForRule
        Expire::KeepHourlyRule
        Expire::KeepDailyRule
        Expire::KeepWeeklyRule
        Expire::KeepMonthlyRule
        Expire::KeepYearlyRule
        Expire::KeepHourlyForRule
        Expire::KeepDailyForRule
        Expire::KeepWeeklyForRule
        Expire::KeepMonthlyForRule
        Expire::KeepYearlyForRule
        Expire::KeepFromNowHourlyForRule
        Expire::KeepFromNowDailyForRule
        Expire::KeepFromNowWeeklyForRule
        Expire::KeepFromNowMonthlyForRule
        Expire::KeepFromNowYearlyForRule
      ]
    end

    it 'returns the class names' do
      expect(described_class.class_names).to contain_exactly(*expected)
    end
  end

  describe '.names' do
    let(:expected) do
      %w[
        keep_most_recent
        keep_most_recent_for
        keep_from_now_most_recent_for
        keep_hourly
        keep_daily
        keep_weekly
        keep_monthly
        keep_yearly
        keep_hourly_for
        keep_daily_for
        keep_weekly_for
        keep_monthly_for
        keep_yearly_for
        keep_from_now_hourly_for
        keep_from_now_daily_for
        keep_from_now_weekly_for
        keep_from_now_monthly_for
        keep_from_now_yearly_for
      ]
    end

    it 'returns the names' do
      expect(described_class.names).to contain_exactly(*expected)
    end
  end

  describe '.name_symbols' do
    let(:expected) do
      %i[
        keep_most_recent
        keep_most_recent_for
        keep_from_now_most_recent_for
        keep_hourly
        keep_daily
        keep_weekly
        keep_monthly
        keep_yearly
        keep_hourly_for
        keep_daily_for
        keep_weekly_for
        keep_monthly_for
        keep_yearly_for
        keep_from_now_hourly_for
        keep_from_now_daily_for
        keep_from_now_weekly_for
        keep_from_now_monthly_for
        keep_from_now_yearly_for
      ]
    end

    it 'returns the names as symbols' do
      expect(described_class.name_symbols).to contain_exactly(*expected)
    end
  end

  describe '.option_names' do
    let(:expected) do
      %w[
        --keep-most-recent
        --keep-most-recent-for
        --keep-from-now-most-recent-for
        --keep-hourly
        --keep-daily
        --keep-weekly
        --keep-monthly
        --keep-yearly
        --keep-hourly-for
        --keep-daily-for
        --keep-weekly-for
        --keep-monthly-for
        --keep-yearly-for
        --keep-from-now-hourly-for
        --keep-from-now-daily-for
        --keep-from-now-weekly-for
        --keep-from-now-monthly-for
        --keep-from-now-yearly-for
      ]
    end

    it 'returns the option_names' do
      expect(described_class.option_names).to contain_exactly(*expected)
    end
  end
end
