# frozen_string_literal: true

require 'support/shared_examples_for_rules'
require 'support/shared_examples_for_adjective_rules'
require 'support/shared_examples_for_from_now_adjective_for_rules'
require 'support/shared_examples_for_rule_apply'
require 'test_dates'

RSpec.describe Expire::FromNowMonthlyForRule do
  subject { described_class.new(amount: 2, unit: 'years') }

  it_behaves_like 'a rule' do
    let(:rank) { 44 }
  end

  it_behaves_like 'an adjective rule' do
    let(:adjective) { 'monthly' }
    let(:spacing) { 'month' }
  end

  it_behaves_like 'an from now adjective-for rule'

  it_behaves_like 'an #apply on a rule' do
    let(:backups) do
      TestDates.create(years: 1858..1860, months: 4..5).to_backups
    end

    let(:kept) do
      TestDates.create(years: 1859..1860, months: 4..5).to_backups
    end

    let(:reference_time) { DateTime.new(1861, 4, 1, 12, 0, 0) }
  end
end