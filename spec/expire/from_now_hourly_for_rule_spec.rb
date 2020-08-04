# frozen_string_literal: true

require 'support/shared_examples_for_rules'
require 'support/shared_examples_for_adjective_rules'
require 'support/shared_examples_for_from_now_adjective_for_rules'
require 'support/shared_examples_for_rule_apply'
require 'test_dates'

RSpec.describe Expire::FromNowHourlyForRule do
  subject { described_class.new(amount: 2, unit: 'days') }

  it_behaves_like 'a rule' do
    let(:rank) { 41 }
  end

  it_behaves_like 'an adjective rule' do
    let(:adjective) { 'hourly' }
    let(:spacing) { 'hour' }
  end

  it_behaves_like 'an from now adjective-for rule'

  it_behaves_like 'an #apply on a rule' do
    let(:backups) { TestDates.create(days: (16..17), hours: 11..12).to_backups }
    let(:kept) { TestDates.create(hours: 11..12).to_backups }
    let(:reference_time) { DateTime.new(1860, 5, 18, 12, 0, 0) }
  end
end
