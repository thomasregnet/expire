# frozen_string_literal: true

RSpec.shared_examples 'a calculate service' do
  it { should respond_to(:backups) }
  it { should respond_to(:call) }
  it { should respond_to(:rules) }
end
