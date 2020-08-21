# frozen_string_literal: true

require 'support/shared_examples_for_rules'
require 'support/shared_examples_for_adjective_rules'
require 'support/shared_examples_for_adjective_rules/apply'

RSpec.describe Expire::DailyRule do
  subject { described_class.new(amount: 3) }

  it_behaves_like 'a rule' do
    let(:name) { 'daily' }
    let(:rank) { 22 }
  end

  it_behaves_like 'an adjective rule' do
    let(:adjective) { 'daily' }
    let(:spacing) { 'day' }
  end

  it_behaves_like 'an applicable adjective rule' do
    let(:adjective) { 'daily' }
  end
end
