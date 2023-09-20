# frozen_string_literal: true

RSpec.shared_examples "a rule" do
  it { should respond_to(:amount) }
  it { should respond_to("<=>") }

  describe ".from_value" do
    context 'when "none"' do
      let(:rule) { described_class.from_value("none") }

      it "has an amount of zero" do
        expect(rule.amount).to eq(0)
      end
    end
  end

  describe "#name" do
    it "returns the right name" do
      expect(subject.name).to eq(name)
    end
  end

  describe "#numerus_backup" do
    context "with an amount of 1" do
      let(:rule) { described_class.from_value("none") }

      before { allow(rule).to receive(:amount).and_return(1) }

      it 'returns "backup" (singular)' do
        expect(rule.numerus_backup).to eq("backup")
      end
    end

    context "with an amount of 10" do
      let(:rule) { described_class.from_value("none") }

      before { allow(rule).to receive(:amount).and_return(10) }

      it 'returns "backup" (plural)' do
        expect(rule.numerus_backup).to eq("backups")
      end
    end
  end

  describe "#option_name" do
    it "returns the right option_name" do
      expect(subject.option_name).to eq(option_name)
    end
  end

  describe ".rank" do
    it "has a rank of" do
      expect(described_class.rank).to eq(rank)
    end
  end

  describe "#rank" do
    it "has a rank of" do
      expect(subject.rank).to eq(rank)
    end
  end

  describe "rules are comparable" do
    let(:other_rule) { double }

    context "when compared with a lower ranked rule" do
      it "returns the rule" do
        allow(other_rule).to receive(:rank).and_return(-99_999)
        expect(subject).to be > other_rule
      end
    end

    context "when compared with a higher ranked rule" do
      it "returns the rule" do
        allow(other_rule).to receive(:rank).and_return(99_999)
        expect(subject).to be < other_rule
      end
    end
  end
end
