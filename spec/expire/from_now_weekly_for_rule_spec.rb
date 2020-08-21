# frozen_string_literal: true

require 'support/shared_examples_for_rules'
require 'support/shared_examples_for_adjective_rules'
require 'support/shared_examples_for_from_now_adjective_for_rules'
require 'support/shared_examples_for_rule_apply'
require 'test_dates'

RSpec.describe Expire::FromNowWeeklyForRule do
  subject { described_class.new(amount: 2, unit: 'weeks') }

  it_behaves_like 'a rule' do
    let(:name)        { 'from_now_weekly_for' }
    let(:option_name) { '--from-now-weekly-for' }
    let(:rank)        { 43 }
  end

  it_behaves_like 'an adjective rule' do
    let(:adjective) { 'weekly' }
    let(:spacing) { 'week' }
  end

  it_behaves_like 'an from now adjective-for rule'

  it_behaves_like 'an #apply on a rule' do
    let(:backups) do
      TestDates.create(days: (12..17), hours: 11..12).to_backups
    end

    let(:kept) do
      TestDates.create(days: (13..17).step(4), hours: 12..12).to_backups
    end

    let(:reference_datetime) { DateTime.new(1860, 5, 24, 12, 0, 0) }
  end
end
