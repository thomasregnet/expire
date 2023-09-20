# frozen_string_literal: true

require "support/shared_examples_for_rules"

RSpec.describe Expire::RuleBase do
  describe "#name" do
    let(:rule) { described_class.new(amount: 1) }

    context "when the rule has a valid class name" do
      before { allow(rule).to receive(:camelized_name).and_return("SomeStuff") }

      it "returns the expected name" do
        expect(rule.name).to eq("some_stuff")
      end
    end

    context "when the rule has an invalid class name" do
      before { allow(rule).to receive(:camelized_name).and_return(nil) }

      it "returns nil" do
        expect(rule.name).to be_nil
      end
    end
  end

  describe "#numerus_backup" do
    context "with an amount of 1" do
      let(:rule) { described_class.new(amount: 1) }

      it 'returns "backup"' do
        expect(rule.numerus_backup).to eq("backup")
      end
    end

    context "with an amount greater than 1" do
      let(:rule) { described_class.new(amount: 11) }

      it 'returns "backups"' do
        expect(rule.numerus_backup).to eq("backups")
      end
    end

    context "with an amount smaller than 0" do
      let(:rule) { described_class.new(amount: -1) }

      it 'returns "backups"' do
        expect(rule.numerus_backup).to eq("backups")
      end
    end

    context "with an amount of 0" do
      let(:rule) { described_class.new(amount: 0) }

      it 'returns "backups"' do
        expect(rule.numerus_backup).to eq("backups")
      end
    end
  end

  describe "#option_name" do
    let(:rule) { described_class.new(amount: 1) }

    context "when the rule has a valid class option_name" do
      before { allow(rule).to receive(:camelized_name).and_return("SomeStuff") }

      it "returns the expected option_name" do
        expect(rule.option_name).to eq("--some-stuff")
      end
    end

    context "when the rule has an invalid class option_name" do
      before { allow(rule).to receive(:camelized_name).and_return(nil) }

      it "returns nil" do
        expect(rule.option_name).to be_nil
      end
    end
  end
end
