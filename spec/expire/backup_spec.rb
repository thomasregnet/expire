# frozen_string_literal: true

RSpec.describe Expire::Backup do
  subject do
    described_class.new(
      time: Time.new(1860, 5, 17, 12, 0, 0),
      pathname: Pathname.new("backups/1860-05-17_12_00_00")
    )
  end

  it { should respond_to :reasons_to_keep }
  it { should respond_to :expired? }
  it { should respond_to :keep? }

  describe "#same_hour?" do
    let(:backup) do
      described_class.new(
        time: Time.new(1860, 5, 17, 12, 0, 0),
        pathname: Pathname.new("backups/1860-05-17_12_00_00")
      )
    end

    context "when the hour is the same" do
      let(:other) do
        described_class.new(
          time: Time.new(1860, 5, 17, 12, 11, 22),
          pathname: Pathname.new("backups/1860-05-17_12_11_22")
        )
      end

      it "returns true" do
        expect(backup).to be_same_hour(other)
      end
    end

    context "when the hour differs" do
      let(:other) do
        described_class.new(
          time: Time.new(1860, 5, 17, 13, 0, 0),
          pathname: Pathname.new("backups/1860-05-17_13_00_00")
        )
      end

      it "returns false" do
        expect(backup).not_to be_same_hour(other)
      end
    end

    context "when the day differs" do
      let(:other) do
        described_class.new(
          time: Time.new(1860, 5, 22, 12, 0, 0),
          pathname: Pathname.new("backups/1860-05-22_12_00_00")
        )
      end

      it "returns false" do
        expect(backup).not_to be_same_hour(other)
      end
    end
  end

  describe "#same_day?" do
    let(:backup) do
      described_class.new(
        time: Time.new(1860, 5, 17, 12, 0, 0),
        pathname: Pathname.new("backups/1860-05-17_12_00_00")
      )
    end

    context "when the day is the same" do
      let(:other) do
        described_class.new(
          time: Time.new(1860, 5, 17, 23, 11, 22),
          pathname: Pathname.new("backups/1860-05-17_23_11_22")
        )
      end

      it "returns true" do
        expect(backup).to be_same_day(other)
      end
    end

    context "when the day differs" do
      let(:other) do
        described_class.new(
          time: Time.new(1860, 5, 18, 13, 0, 0),
          pathname: Pathname.new("backups/1860-05-18_13_00_00")
        )
      end

      it "returns false" do
        expect(backup).not_to be_same_day(other)
      end
    end

    context "when the month differs" do
      let(:other) do
        described_class.new(
          time: Time.new(1860, 4, 22, 12, 0, 0),
          pathname: Pathname.new("backups/1860-04-22_12_00_00")
        )
      end

      it "returns false" do
        expect(backup).not_to be_same_day(other)
      end
    end
  end

  describe "#same_week?" do
    let(:backup) do
      described_class.new(
        time: Time.new(1860, 5, 17, 12, 0, 0),
        pathname: Pathname.new("backups/1860-05-17_12_00_00")
      )
    end

    context "when the week is the same" do
      let(:other) do
        described_class.new(
          time: Time.new(1860, 5, 15, 12, 0, 0),
          pathname: Pathname.new("backups/1860-05-15_12_00_00")
        )
      end

      it "returns true" do
        expect(backup).to be_same_week(other)
      end
    end

    context "when the week differs" do
      let(:other) do
        described_class.new(
          time: Time.new(1860, 5, 22, 13, 0, 0),
          pathname: Pathname.new("backups/1860-05-22_13_00_00")
        )
      end

      it "returns false" do
        expect(backup).not_to be_same_week(other)
      end
    end

    context "when the month differs" do
      let(:other) do
        described_class.new(
          time: Time.new(1860, 4, 15, 22, 0, 0),
          pathname: Pathname.new("backups/1860-04-15_22_00_00")
        )
      end

      it "returns false" do
        expect(backup).not_to be_same_week(other)
      end
    end
  end

  describe "#same_month?" do
    let(:backup) do
      described_class.new(
        time: Time.new(1860, 5, 17, 12, 0, 0),
        pathname: Pathname.new("backups/1860-05-17_12_00_00")
      )
    end

    context "when the month is the same" do
      let(:other) do
        described_class.new(
          time: Time.new(1860, 5, 1, 12, 0, 0),
          pathname: Pathname.new("backups/1860-01-12_12_00_00")
        )
      end

      it "returns true" do
        expect(backup).to be_same_month(other)
      end
    end

    context "when the month differs" do
      let(:other) do
        described_class.new(
          time: Time.new(1860, 3, 17, 13, 0, 0),
          pathname: Pathname.new("backups/1860-03-17_13_00_00")
        )
      end

      it "returns false" do
        expect(backup).not_to be_same_month(other)
      end
    end

    context "when the year differs" do
      let(:other) do
        described_class.new(
          time: Time.new(1859, 5, 17, 12, 0, 0),
          pathname: Pathname.new("backups/1860-05-17_12_00_00")
        )
      end

      it "returns false" do
        expect(backup).not_to be_same_week(other)
      end
    end
  end

  describe "#same_year?" do
    let(:backup) do
      described_class.new(
        time: Time.new(1860, 5, 17, 12, 0, 0),
        pathname: Pathname.new("backups/1860-05-17_12_00_00")
      )
    end

    context "when the year is the same" do
      let(:other) do
        described_class.new(
          time: Time.new(1860, 2, 15, 1, 10, 30),
          pathname: Pathname.new("backups/1860-05-15_01_10_30")
        )
      end

      it "returns true" do
        expect(backup).to be_same_year(other)
      end
    end

    context "when the year differs" do
      let(:other) do
        described_class.new(
          time: Time.new(1859, 5, 17, 12, 0, 0),
          pathname: Pathname.new("backups/1859-05-17_12_00_00")
        )
      end

      it "returns false" do
        expect(backup).not_to be_same_year(other)
      end
    end
  end

  describe "#expired?" do
    let(:backup) do
      described_class.new(
        time: Time.new(1860, 5, 17, 12, 0, 0),
        pathname: Pathname.new("backups/1860-05-17_12_00_00")
      )
    end

    context "with reasons_to_keep" do
      before { backup.add_reason_to_keep("want to keep") }

      it "returns false" do
        expect(backup).not_to be_expired
      end
    end

    context "without reasons_to_keep" do
      it "returns true" do
        expect(backup).to be_expired
      end
    end
  end

  describe "#keep?" do
    let(:backup) do
      described_class.new(
        time: Time.new(1860, 5, 17, 12, 0, 0),
        pathname: Pathname.new("backups/1860-05-17_12_00_00")
      )
    end

    context "with reasons_to_keep" do
      before { backup.add_reason_to_keep("want to keep") }

      it "returns true" do
        expect(backup).to be_keep
      end
    end

    context "without reasons_to_keep" do
      it "returns false" do
        expect(backup).not_to be_keep
      end
    end
  end

  describe "#reasons_to_keep" do
    let(:backup) do
      described_class.new(
        time: Time.new(1860, 5, 17, 12, 0, 0),
        pathname: Pathname.new("backups/1860-05-17_12_00_00")
      )
    end

    it "returns a Set" do
      expect(backup.reasons_to_keep).to be_instance_of(Set)
    end
  end
end
