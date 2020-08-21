# frozen_string_literal: true

require 'expire/commands/rule_names'

RSpec.describe Expire::Commands::RuleNames do
  def expected
    <<~EXPECTED
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
