# frozen_string_literal: true

RSpec.describe Expire::RuleList do
  describe '.class_names' do
    let(:expected) do
      %w[
        Expire::MostRecentRule
        Expire::MostRecentForRule
        Expire::FromNowMostRecentForRule
        Expire::HourlyRule
        Expire::DailyRule
        Expire::WeeklyRule
        Expire::MonthlyRule
        Expire::YearlyRule
        Expire::HourlyForRule
        Expire::DailyForRule
        Expire::WeeklyForRule
        Expire::MonthlyForRule
        Expire::YearlyForRule
        Expire::FromNowHourlyForRule
        Expire::FromNowDailyForRule
        Expire::FromNowWeeklyForRule
        Expire::FromNowMonthlyForRule
        Expire::FromNowYearlyForRule
      ]
    end

    it 'returns the class names' do
      expect(described_class.class_names).to contain_exactly(*expected)
    end
  end

  describe '.names' do
    let(:expected) do
      %w[
        most_recent
        most_recent_for
        from_now_most_recent_for
        hourly
        daily
        weekly
        monthly
        yearly
        hourly_for
        daily_for
        weekly_for
        monthly_for
        yearly_for
        from_now_hourly_for
        from_now_daily_for
        from_now_weekly_for
        from_now_monthly_for
        from_now_yearly_for
      ]
    end

    it 'returns the names' do
      expect(described_class.names).to contain_exactly(*expected)
    end
  end
end
