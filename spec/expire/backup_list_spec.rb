# frozen_string_literal: true

require "test_dates"

RSpec.describe Expire::BackupList do
  describe "#backups" do
    context "when initialized without any backups" do
      it "returns an empty array" do
        expect(described_class.new.backups).to be_empty
      end
    end
  end

  describe "#most_recent" do
    let(:backups) do
      described_class.new(
        [
          Expire::Backup.new(
            time: Time.new(1860, 5, 17, 12, 0, 0),
            pathname: Pathname.new("backups/oldest")
          ),

          Expire::Backup.new(
            time: Time.new(1860, 5, 17, 12, 44, 0),
            pathname: Pathname.new("backups/newest")
          ),
          Expire::Backup.new(
            time: Time.new(1860, 5, 17, 12, 36, 0),
            pathname: Pathname.new("backups/middle")
          )
        ]
      )
    end

    context "without parameter" do
      it "returns an instance of #{described_class}" do
        expect(backups.most_recent).to be_instance_of(described_class)
      end

      it "returns one backup" do
        expect(backups.most_recent.length).to eq(1)
      end

      it "returns the most recent backup" do
        expect(backups.most_recent.last.pathname.to_s).to eq("backups/newest")
      end
    end

    context "with 2 as parameter" do
      it "returns an Array with one element" do
        expect(backups.most_recent(2).length).to eq(2)
      end

      it "returns the most recent backup" do
        paths = backups.most_recent(2).map { |backup| backup.pathname.to_s }
        expect(paths).to eq(%w[backups/newest backups/middle])
      end
    end

    context "with a parameter that exceeds the amount of backups" do
      it "returns an Array with the backups" do
        expect(backups.most_recent(99).length).to eq(3)
      end
    end
  end

  describe "#newest" do
    let(:backup_list) do
      described_class.new(
        [
          Expire::Backup.new(
            time: Time.new(1860, 5, 17, 12, 0, 0),
            pathname: Pathname.new("fake_path")
          ),

          Expire::Backup.new(
            time: Time.new(1860, 5, 17, 12, 44, 0),
            pathname: Pathname.new("fake_path")
          )
        ]
      )
    end

    it "returns the newest backup" do
      # Since we are working with dates without
      # time zone we omit the +-\d\d:\d\d part
      expect(backup_list.newest.to_s).to match(/\A1860-05-17T12:44/)
    end
  end

  describe "#oldest" do
    let(:backup_list) do
      described_class.new(
        [
          Expire::Backup.new(
            time: Time.new(1860, 5, 17, 12, 0, 0),
            pathname: Pathname.new("fake_path")
          ),

          Expire::Backup.new(
            time: Time.new(1860, 5, 17, 12, 44, 0),
            pathname: Pathname.new("fake_path")
          )
        ]
      )
    end

    it "returns the newest backup" do
      # Since we are working with dates without
      # time zone we omit the +-\d\d:\d\d part
      expect(backup_list.oldest.to_s).to match(/\A1860-05-17T12:00/)
    end
  end

  describe "#not_older_than" do
    let(:backups) { TestDates.create(days: 15..17).to_backups }

    context "with no backup not older than reference time" do
      let(:reference_time) { Time.new(1860, 5, 17, 12, 0, 1) }
      let(:kept) { described_class.new }

      it "returns all backups not older than the reference time" do
        expect(backups.not_older_than(reference_time))
          .to contain_exactly(*kept)
      end
    end

    context "with all backups not older than reference time" do
      let(:reference_time) { Time.new(1860, 5, 15, 12, 0, 0) }
      let(:kept) { TestDates.create(days: 15..17).to_backups }

      it "returns all backups not older than the reference time" do
        expect(backups.not_older_than(reference_time))
          .to contain_exactly(*kept)
      end
    end

    context "with some backups not older than reference time" do
      let(:reference_time) { Time.new(1860, 5, 15, 12, 0, 1) }
      let(:kept) { TestDates.create(days: 16..17).to_backups }

      it "returns all backups not older than the reference time" do
        expect(backups.not_older_than(reference_time))
          .to contain_exactly(*kept)
      end
    end
  end

  describe "#one_per" do
    context "with :hour" do
      let(:hourly) do
        described_class.new(
          [
            Expire::Backup.new(
              time: Time.new(1860, 5, 17, 12, 0, 0),
              pathname: Pathname.new("fake_path")
            ),

            Expire::Backup.new(
              time: Time.new(1860, 5, 17, 12, 44, 0),
              pathname: Pathname.new("fake_path")
            ),
            Expire::Backup.new(
              time: Time.new(1860, 5, 17, 12, 36, 0),
              pathname: Pathname.new("fake_path")
            ),

            Expire::Backup.new(
              time: Time.new(1860, 5, 17, 12, 33, 0),
              pathname: Pathname.new("fake_path")
            ),

            Expire::Backup.new(
              time: Time.new(1860, 5, 17, 13, 0, 0),
              pathname: Pathname.new("fake_path")
            )
          ]
        ).one_per(:hour)
      end

      it "returns an instance of #{described_class}" do
        expect(hourly).to be_instance_of(described_class)
      end

      # rubocop:disable RSpec/ExampleLength
      it "returns hourly backups" do
        expect(hourly).to contain_exactly(
          Expire::Backup.new(
            time: Time.new(1860, 5, 17, 12, 44, 0),
            pathname: :fake_path
          ),
          Expire::Backup.new(
            time: Time.new(1860, 5, 17, 13, 0, 0),
            pathname: :fake_path
          )
        )
      end
      # rubocop:enable RSpec/ExampleLength
    end

    context "when empty" do
      let(:backup_list) { described_class.new }

      it "returns an empty instance" do
        expect(backup_list.one_per(:hour)).to be_empty
      end

      it "returns a new instance" do
        expect(backup_list.one_per(:day)).not_to eq(backup_list)
      end
    end
  end

  describe "after expire" do
    let(:expired_one) { instance_double("Expire::Backup") }
    let(:expired_two) { instance_double("Expire::Backup") }
    let(:kept_one) { instance_double("Expire::Backup") }

    let(:backups) do
      described_class.new([expired_one, expired_two, kept_one])
    end

    describe "#expired" do
      before do
        allow(expired_one).to receive(:expired?).and_return(true)
        allow(expired_two).to receive(:expired?).and_return(true)
        allow(kept_one).to receive(:expired?).and_return(false)
      end

      it "returns the expired backups" do
        expect(backups.expired.length).to eq(2)
      end

      it "returns an instance of #{described_class}" do
        expect(backups.expired).to be_instance_of(described_class)
      end
    end

    describe "#expired_count" do
      it "returns the amount of expired backups" do
        allow(backups).to receive(:expired).and_return([0, 1])
        expect(backups.expired_count).to eq(2)
      end
    end

    describe "#keep" do
      before do
        allow(expired_one).to receive(:keep?).and_return(false)
        allow(expired_two).to receive(:keep?).and_return(false)
        allow(kept_one).to receive(:keep?).and_return(true)
      end

      it "returns the backups to be kept" do
        expect(backups.keep.length).to eq(1)
      end

      it "returns an instance of #{described_class}" do
        expect(backups.keep).to be_instance_of(described_class)
      end
    end

    describe "#keep_count" do
      it "returns the backups to be kept" do
        allow(expired_one).to receive(:keep?).and_return(false)
        allow(expired_two).to receive(:keep?).and_return(false)
        allow(kept_one).to receive(:keep?).and_return(true)

        expect(backups.keep_count).to eq(1)
      end
    end

    # describe '#purge' do
    #   # No verifying double for backup because #id is delegated
    #   let(:backup) { instance_double('Expire::Backup') }
    #   let(:report) { instance_double('Expire::ReportNull') }
    #   let(:result) { described_class.new([backup]) }

    #   before do
    #     allow(report).to receive(:before_purge)
    #     allow(report).to receive(:after_purge)
    #     allow(backup).to receive(:path).and_return(:fake_path)
    #     allow(backup).to receive(:expired?).and_return(true)
    #     allow(FileUtils).to receive(:rm_rf)
    #   end

    #   it 'calls FileUtils.rm_rf' do
    #     result.purge(report)

    #     expect(FileUtils).to have_received(:rm_rf)
    #   end
    # end
  end
end
