# frozen_string_literal: true

require 'support/shared_examples_for_rules'
require 'support/shared_examples_for_adjective_rules'
require 'support/shared_examples_for_adjective_for_rules'
require 'support/shared_examples_for_rule_apply'
require 'test_dates'

RSpec.describe Expire::WeeklyForRule do
  subject { described_class.new(amount: 2, unit: 'weeks') }

  it_behaves_like 'a rule' do
    let(:name) { 'weekly_for' }
    let(:rank) { 33 }
  end

  it_behaves_like 'an adjective rule' do
    let(:adjective) { 'weekly' }
    let(:spacing) { 'week' }
  end

  it_behaves_like 'an adjective-for rule'

  it_behaves_like 'an #apply on a rule' do
    let(:backups) { TestDates.create(days: (12..20)).to_backups }
    let(:kept) { TestDates.create(days: (13..20).step(7)).to_backups }
    let(:reference_datetime) { nil }
  end
end
