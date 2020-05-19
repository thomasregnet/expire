# frozen_string_literal: true

RSpec.shared_examples 'a CalculateAdjectiveServiceBase class' do
  it { should respond_to(:adjective) }
  it { should respond_to(:noun) }

  it_behaves_like 'a CalculateServiceBase class'
end
