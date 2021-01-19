# frozen_string_literal: true

RSpec.shared_examples 'a reporter' do
  it { should respond_to(:before_all) }
  it { should respond_to(:after_all) }

  it { should respond_to(:on_keep) }

  it { should respond_to(:before_purge) }
  it { should respond_to(:after_purge) }
end
