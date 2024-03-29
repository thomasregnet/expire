# frozen_string_literal: true

require "support/shared_examples_for_rules"
require "support/shared_examples_for_adjective_rules"
require "support/shared_examples_for_from_now_adjective_for_rules"
require "support/shared_examples_for_rule_apply"
require "support/shared_examples_for_unit_rules"
require "test_dates"

RSpec.describe Expire::FromNowKeepHourlyForRule do
  subject { described_class.new(amount: 2, unit: "days") }

  it_behaves_like "a rule" do
    let(:name) { "from_now_keep_hourly_for" }
    let(:option_name) { "--from-now-keep-hourly-for" }
    let(:rank) { 41 }
  end

  it_behaves_like "an adjective rule" do
    let(:adjective) { "hourly" }
    let(:spacing) { "hour" }
  end

  it_behaves_like "an from now adjective-for rule"

  it_behaves_like "an #apply on a rule" do
    let(:backups) { TestDates.create(days: (15..17), hours: 11..12).to_backups }
    let(:kept) { TestDates.create(days: 16..17, hours: 11..12).to_backups }
    let(:reference_time) { Time.new(1860, 5, 18, 10, 33, 0) }
  end

  it_behaves_like "an unit rule"
end
