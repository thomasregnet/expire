# frozen_string_literal: true

require 'expire/commands/rule_option_names'

RSpec.describe Expire::Commands::RuleOptionNames do
  def expected
    <<~EXPECTED
      --most-recent
      --most-recent-for
      --from-now-most-recent-for
      --hourly
      --daily
      --weekly
      --monthly
      --yearly
      --hourly-for
      --daily-for
      --weekly-for
      --monthly-for
      --yearly-for
      --from-now-hourly-for
      --from-now-daily-for
      --from-now-weekly-for
      --from-now-monthly-for
      --from-now-yearly-for
    EXPECTED
  end
  it 'executes `rule_option_names` command successfully' do
    output = StringIO.new
    options = {}
    command = Expire::Commands::RuleOptionNames.new(options)

    command.execute(output: output)

    expect(output.string).to eq(expected)
  end
end
