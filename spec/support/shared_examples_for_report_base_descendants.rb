# frozen_string_literal: true

RSpec.shared_examples "a ReportBase descendant" do
  it { should respond_to(:receiver) }
end
