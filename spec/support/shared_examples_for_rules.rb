# frozen_string_literal: true

RSpec.shared_examples 'a rule' do
  it { should respond_to(:amount) }
  it { should respond_to(:name) }
end
