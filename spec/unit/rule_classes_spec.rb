# frozen_string_literal: true

require 'expire/commands/rule_classes'

RSpec.describe Expire::Commands::RuleClasses do
  def expected
    <<~EXPECTED
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
      Expire::FromNowKeepHourlyForRule
      Expire::FromNowKeepDailyForRule
      Expire::FromNowKeepWeeklyForRule
      Expire::FromNowKeepMonthlyForRule
      Expire::FromNowKeepYearlyForRule
    EXPECTED
  end

  it 'executes `rule_classes` command successfully' do
    output = StringIO.new
    options = {}
    command = described_class.new(options)

    command.execute(output: output)

    expect(output.string).to eq(expected)
  end
end
