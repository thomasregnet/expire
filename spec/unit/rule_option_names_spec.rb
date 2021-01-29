# frozen_string_literal: true

require 'expire/commands/rule_option_names'

RSpec.describe Expire::Commands::RuleOptionNames do
  def expected
    <<~EXPECTED
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
