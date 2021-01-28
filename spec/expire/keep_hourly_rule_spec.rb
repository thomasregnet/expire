# frozen_string_literal: true

require 'support/shared_examples_for_rules'
require 'support/shared_examples_for_adjective_rules'
require 'support/shared_examples_for_adjective_rules/apply'
require 'support/shared_examples_for_keep_all_rules'

RSpec.describe Expire::KeepHourlyRule do
  subject { described_class.new(amount: 3) }

  it_behaves_like 'a rule' do
    let(:name)        { 'keep_hourly' }
    let(:option_name) { '--keep-hourly' }
    let(:rank)        { 21 }
  end

  it_behaves_like 'an adjective rule' do
    let(:adjective) { 'hourly' }
    let(:spacing) { 'hour' }
  end

  it_behaves_like 'an applicable adjective rule' do
    let(:adjective) { 'hourly' }
  end

  it_behaves_like 'a keep all rule'
end
