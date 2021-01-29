# frozen_string_literal: true

require 'expire/commands/rule_names'

RSpec.describe Expire::Commands::RuleNames do
  def expected
    <<~EXPECTED
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
    EXPECTED
  end

  it 'executes `rule_names` command successfully' do
    output = StringIO.new
    options = {}
    command = described_class.new(options)

    command.execute(output: output)

    expect(output.string).to eq(expected)
  end
end
