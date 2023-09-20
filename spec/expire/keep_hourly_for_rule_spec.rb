# frozen_string_literal: true

require "support/shared_examples_for_rules"
require "support/shared_examples_for_adjective_rules"
require "support/shared_examples_for_adjective_for_rules"
require "support/shared_examples_for_rule_apply"
require "test_dates"

RSpec.describe Expire::KeepHourlyForRule do
  subject { described_class.new(amount: 2, unit: "hours") }

  it_behaves_like "a rule" do
    let(:name) { "keep_hourly_for" }
    let(:option_name) { "--keep-hourly-for" }
    let(:rank) { 31 }
  end

  it_behaves_like "an adjective rule" do
    let(:adjective) { "hourly" }
    let(:spacing) { "hour" }
  end

  it_behaves_like "an adjective-for rule"

  it_behaves_like "an #apply on a rule" do
    let(:backups) { TestDates.create(days: 15..17, hours: 11..12).to_backups }
    let(:kept) { TestDates.create(hours: 11..12).to_backups }
    let(:reference_time) { nil }
  end
end
