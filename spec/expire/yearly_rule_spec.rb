# frozen_string_literal: true

require 'support/shared_examples_for_rules'
require 'support/shared_examples_for_adjective_rules'
require 'support/shared_examples_for_adjective_rules/apply'

RSpec.describe Expire::YearlyRule do
  subject { described_class.new(amount: 3) }

  it_behaves_like 'a rule' do
    let(:name)        { 'yearly' }
    let(:option_name) { '--yearly' }
    let(:rank)        { 25 }
  end

  it_behaves_like 'an adjective rule' do
    let(:adjective) { 'yearly' }
    let(:spacing) { 'year' }
  end

  it_behaves_like 'an applicable adjective rule' do
    let(:adjective) { 'yearly' }
  end
end
