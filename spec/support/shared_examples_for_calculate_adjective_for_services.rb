# frozen_string_literal: true

require 'support/shared_examples_for_calculate_adjective_services'

RSpec.shared_examples 'a calculate adjective for service' do
  it { should respond_to(:now) }

  it_behaves_like 'a calculate adjective service'
end
