# frozen_string_literal: true

require 'expire/commands/rule_classes'

RSpec.describe Expire::Commands::RuleClasses do
  def expected
    <<~EXPECTED
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
    EXPECTED
  end

  it 'executes `rule_classes` command successfully' do
    output = StringIO.new
    options = {}
    command = Expire::Commands::RuleClasses.new(options)

    command.execute(output: output)

    expect(output.string).to eq(expected)
  end
end
