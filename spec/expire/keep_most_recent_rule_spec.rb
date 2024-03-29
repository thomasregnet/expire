# frozen_string_literal: true

require "support/shared_examples_for_rules"

RSpec.describe Expire::KeepMostRecentRule do
  subject { described_class.new(amount: 1) }

  it_behaves_like "a rule" do
    let(:name) { "keep_most_recent" }
    let(:option_name) { "--keep-most-recent" }
    let(:rank) { 10 }
  end

  describe "#apply" do
    let(:backup_one) { instance_double("Expire::Backup") }
    let(:backup_two) { instance_double("Expire::Backup") }

    let(:backups) { instance_double("Expire::BackupList") }

    context "with an amount of 1" do
      let(:rule) { described_class.new(amount: 1) }

      before do
        allow(backups).to receive(:most_recent)
          .with(1)
          .and_return(Expire::BackupList.new([backup_one]))

        allow(backup_one).to receive(:add_reason_to_keep)

        rule.apply(backups, :dummy_reference_time)
      end

      it "adds a reason_to_keep to the most recent backup" do
        expect(backup_one)
          .to have_received(:add_reason_to_keep)
          .with("keep the most recent backup")
      end
    end

    context "with an amount of 2" do
      let(:rule) { described_class.new(amount: 2) }

      before do
        allow(backups).to receive(:most_recent)
          .with(2)
          .and_return(
            Expire::BackupList.new(
              [backup_one, backup_two]
            )
          )
        allow(backup_one).to receive(:add_reason_to_keep)
        allow(backup_two).to receive(:add_reason_to_keep)

        rule.apply(backups, :dummy_reference_time)
      end

      it "adds a reason_to_keep to the most recent backup" do
        expect(backup_one)
          .to have_received(:add_reason_to_keep)
          .with("keep the 2 most recent backups")
      end

      it "adds a reason_to_keep to the second recent backup" do
        expect(backup_two)
          .to have_received(:add_reason_to_keep)
          .with("keep the 2 most recent backups")
      end
    end
  end
end
