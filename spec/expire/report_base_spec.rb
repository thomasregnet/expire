# frozen_string_literal: true

require "support/shared_examples_for_reporters"
require "support/shared_examples_for_report_base_descendants"

RSpec.describe Expire::ReportBase do
  it_behaves_like "a reporter"
  it_behaves_like "a ReportBase descendant"

  describe "#error" do
    let(:message) { "bad evil" }
    let(:pastel) { spy }
    let(:report) { described_class.new }

    it "calls pastel.red(message)" do
      allow(report).to receive(:pastel).and_return(pastel)
      report.error(message)
      expect(pastel).to have_received(:red).with(message)
    end
  end

  describe "#pastel" do
    it "returns an instance of Pastel::Delegator" do
      expect(described_class.new.pastel).to be_instance_of(Pastel::Delegator)
    end
  end
end
