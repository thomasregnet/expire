# frozen_string_literal: true

require 'support/shared_examples_for_from_span_value_rules'
require 'support/shared_examples_for_rules'
require 'test_dates'

RSpec.describe Expire::KeepAdjectiveForRuleBase do
  subject { described_class.new(amount: 1, unit: 'year') }

  it { should respond_to(:unit) }

  it_behaves_like 'a from span-value rule'
end
