# frozen_string_literal: true

require 'support/shared_examples_for_rules'
require 'support/shared_examples_for_adjective_rules'
require 'support/shared_examples_for_adjective_for_rules'
require 'support/shared_examples_for_rule_apply'
require 'test_dates'

RSpec.describe Expire::DailyForRule do
  subject { described_class.new(amount: 2, unit: 'days') }

  it_behaves_like 'a rule' do
    let(:rank) { 32 }
  end

  it_behaves_like 'an adjective rule' do
    let(:adjective) { 'daily' }
    let(:spacing) { 'day' }
  end

  it_behaves_like 'an adjective-for rule'

  it_behaves_like 'an #apply on a rule' do
    let(:backups) { TestDates.create(days: 14..17, hours: 11..12).to_backups }
    let(:kept) { TestDates.create(days: 15..17, hours: 12).to_backups }
    let(:reference_datetime) { nil }
  end
end
