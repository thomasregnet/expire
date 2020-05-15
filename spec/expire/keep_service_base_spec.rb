# frozen_string_literal: true

require 'support/shared_examples_for_keep_services'

RSpec.describe Expire::KeepServiceBase do
  it_behaves_like 'a keep service'
end
