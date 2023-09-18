# frozen_string_literal: true

RSpec.shared_examples "an unit rule" do
  describe "#numerus_unit" do
    context "with an amount of 1" do
      let(:rule) { described_class.from_value("none") }

      before do
        allow(rule).to receive(:amount).and_return(1)
        allow(rule).to receive(:unit).and_return("rabbit")
      end

      it "returns the singular" do
        expect(rule.numerus_unit).to eq("rabbit")
      end
    end

    context "with an amount of 10" do
      let(:rule) { described_class.from_value("none") }

      before do
        allow(rule).to receive(:amount).and_return(10)
        allow(rule).to receive(:unit).and_return("rabbit")
      end

      it "returns the plural" do
        expect(rule.numerus_unit).to eq("rabbits")
      end
    end
  end
end
