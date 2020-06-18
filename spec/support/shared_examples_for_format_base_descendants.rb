# frozen_string_literal: true

RSpec.shared_examples 'a FormatBase descendant' do
  it { should respond_to(:receiver) }
end
