# frozen_string_literal: true

RSpec.shared_examples 'a calculate adjective service' do
  it { should respond_to(:adjective) }
  it { should respond_to(:noun) }

  it_behaves_like 'a calculate service'
end
