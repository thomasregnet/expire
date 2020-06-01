# frozen_string_literal: true

require 'support/shared_examples_for_couriers'

RSpec.describe Expire::NullCourier do
  it_behaves_like 'a courier'
end
