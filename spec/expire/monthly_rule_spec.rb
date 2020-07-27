# frozen_string_literal: true

require 'support/shared_examples_for_adjective_rules'

RSpec.describe Expire::MonthlyRule do
  subject { described_class.new(amount: 3) }

  it_behaves_like 'an adjective rule' do
    let(:spacing) { 'month' }
  end
end
