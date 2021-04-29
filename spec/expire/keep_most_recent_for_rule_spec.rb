# frozen_string_literal: true

require 'support/shared_examples_for_from_span_value_rules'
require 'support/shared_examples_for_rule_apply'
require 'support/shared_examples_for_rules'
require 'support/shared_examples_for_unit_rules'
require 'test_dates'

RSpec.describe Expire::KeepMostRecentForRule do
  subject { described_class.new(amount: 2, unit: 'days') }

  it_behaves_like 'a rule' do
    let(:name)        { 'keep_most_recent_for' }
    let(:option_name) { '--keep-most-recent-for' }
    let(:rank)        { 11 }
  end

  it_behaves_like 'an #apply on a rule' do
    let(:backups) { TestDates.create(days: 14..17).to_backups }
    let(:kept) { TestDates.create(days: 15..17).to_backups }
    let(:reference_time) { nil }
  end

  it_behaves_like 'a from span-value rule'

  it_behaves_like 'an unit rule'
end
