# frozen_string_literal: true

RSpec.shared_examples "a from span-value rule" do
  describe ".from_value" do
    context 'with "3 years" as value' do
      let(:rule) { described_class.from_value("3 years") }

      it "has an amount of 3" do
        expect(rule.amount).to eq(3)
      end

      it 'has "year" as unit' do
        expect(rule.unit).to eq("year")
      end
    end

    context 'with "none" as value' do
      let(:rule) { described_class.from_value("none") }

      it "has an amount of 0" do
        expect(rule.amount).to be(0)
      end

      it "has no unit" do
        expect(rule.unit).to be_nil
      end
    end
  end
end
