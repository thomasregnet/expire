# frozen_string_literal: true

require 'support/shared_examples_for_rules'

RSpec.describe Expire::Rule do
  subject { described_class.new(amount: 1) }

  it_behaves_like 'a rule'
end
