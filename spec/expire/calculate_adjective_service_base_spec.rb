# frozen_string_literal: true

require 'support/shared_examples_for_calculate_services'
require 'support/shared_examples_for_calculate_adjective_services'

RSpec.describe Expire::CalculateAdjectiveServiceBase do
  subject do
    described_class.new(
      adjective: :fake_adjective,
      backups:   :fake_backups,
      noun:      :fake_noun,
      rules:     :rules
    )
  end

  it_behaves_like 'a calculate adjective service'
end
