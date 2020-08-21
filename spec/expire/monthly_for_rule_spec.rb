# frozen_string_literal: true

require 'support/shared_examples_for_rules'
require 'support/shared_examples_for_adjective_rules'
require 'support/shared_examples_for_adjective_for_rules'
require 'support/shared_examples_for_rule_apply'
require 'test_dates'

RSpec.describe Expire::MonthlyForRule do
  subject { described_class.new(amount: 2, unit: 'months') }

  it_behaves_like 'a rule' do
    let(:name)        { 'monthly_for' }
    let(:option_name) { '--monthly-for' }
    let(:rank)        { 34 }
  end

  it_behaves_like 'an adjective rule' do
    let(:adjective) { 'monthly' }
    let(:spacing) { 'month' }
  end

  it_behaves_like 'an adjective-for rule'

  it_behaves_like 'an #apply on a rule' do
    let(:backups) do
      TestDates.create(months: 2..5, days: (1..31).step(7)).to_backups
    end

    let(:kept) do
      TestDates.create(months: 3..5, days: (29..29)).to_backups
    end

    let(:reference_datetime) { nil }
  end
end
