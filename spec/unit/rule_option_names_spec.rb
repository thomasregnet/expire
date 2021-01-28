# frozen_string_literal: true

require 'expire/commands/rule_option_names'

RSpec.describe Expire::Commands::RuleOptionNames do
  def expected
    <<~EXPECTED
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
    EXPECTED
  end
  it 'executes `rule_option_names` command successfully' do
    output = StringIO.new
    options = {}
    command = described_class.new(options)

    command.execute(output: output)

    expect(output.string).to eq(expected)
  end
end
