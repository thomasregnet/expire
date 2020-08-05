# frozen_string_literal: true

require 'support/shared_examples_for_rule_apply'
require 'support/shared_examples_for_rules.rb'
require 'test_dates'

RSpec.describe Expire::FromNowMostRecentForRule do
  subject { described_class.new(amount: 2, unit: 'days') }

  it_behaves_like 'a rule' do
    let(:rank) { 12 }
  end

  it_behaves_like 'an #apply on a rule' do
    let(:backups) { TestDates.create(days: 15..17).to_backups }
    let(:kept) { TestDates.create(days: 16..17).to_backups }
    let(:reference_time) { DateTime.new(1860, 5, 18, 12, 0, 0) }
  end
end
