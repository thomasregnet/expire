# frozen_string_literal: true

require 'support/shared_examples_for_rules'
require 'support/shared_examples_for_adjective_rules'
require 'support/shared_examples_for_adjective_for_rules'

RSpec.describe Expire::HourlyForRule do
  subject { described_class.new(amount: 2, unit: 'hour') }

  it_behaves_like 'a rule' do
    let(:rank) { 31 }
  end

  it_behaves_like 'an adjective rule' do
    let(:adjective) { 'hourly' }
    let(:spacing) { 'hour' }
  end

  it_behaves_like 'an adjective-for rule'
end
