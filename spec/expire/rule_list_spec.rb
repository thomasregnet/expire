# frozen_string_literal: true

RSpec.describe Expire::RuleList do
  describe '.class_names' do
    let(:expected) do
      %w[
        Expire::KeepMostRecentRule
        Expire::KeepMostRecentForRule
        Expire::FromNowKeepMostRecentForRule
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
        Expire::FromNowKeepHourlyForRule
        Expire::FromNowKeepDailyForRule
        Expire::FromNowKeepWeeklyForRule
        Expire::FromNowKeepMonthlyForRule
        Expire::FromNowKeepYearlyForRule
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
        from_now_keep_most_recent_for
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
        from_now_keep_hourly_for
        from_now_keep_daily_for
        from_now_keep_weekly_for
        from_now_keep_monthly_for
        from_now_keep_yearly_for
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
        from_now_keep_most_recent_for
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
        from_now_keep_hourly_for
        from_now_keep_daily_for
        from_now_keep_weekly_for
        from_now_keep_monthly_for
        from_now_keep_yearly_for
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
        --from-now-keep-most-recent-for
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
        --from-now-keep-hourly-for
        --from-now-keep-daily-for
        --from-now-keep-weekly-for
        --from-now-keep-monthly-for
        --from-now-keep-yearly-for
      ]
    end

    it 'returns the option_names' do
      expect(described_class.option_names).to contain_exactly(*expected)
    end
  end
end
