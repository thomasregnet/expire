# frozen_string_literal: true

require 'English'

RSpec.describe '`expire purge` command', type: :cli do
  describe '`expire help purge`' do
    let(:expected_output) do
      <<~OUT
        Usage:
          expire purge PATH

        Options:
          -h, [--help], [--no-help]                                            # Display usage information
          -f, [--format=FORMAT]                                                # output format
                                                                               # Default: none
                                                                               # Possible values: expired, kept, none, simple, enhanced
          --cmd, [--purge-command=PURGE_COMMAND]                               # run command to purge the backup
          -r, [--rules-file=RULES_FILE]                                        # read expire-rules from file
          -s, [--simulate], [--no-simulate]                                    # Simulate purge, do not delete anything
              [--keep-most-recent=KEEP_MOST_RECENT]                            # keep the <integer> most recent backups
              [--keep-most-recent-for=KEEP_MOST_RECENT_FOR]                    # keep the most recent backups for <integer> <unit>
              [--from-now-keep-most-recent-for=FROM_NOW_KEEP_MOST_RECENT_FOR]  # keep the most recent backups for <integer> <unit> calculated from now
              [--keep-hourly=KEEP_HOURLY]                                      # keep the <integer> most recent backups from different hours
              [--keep-daily=KEEP_DAILY]                                        # keep the <integer> most recent backups from different days
              [--keep-weekly=KEEP_WEEKLY]                                      # keep the <integer> most recent backups from different weeks
              [--keep-monthly=KEEP_MONTHLY]                                    # keep the <integer> most recent backups from different months
              [--keep-yearly=KEEP_YEARLY]                                      # keep the <integer> most recent backups from different years
              [--keep-hourly-for=KEEP_HOURLY_FOR]                              # keep one backup per hour for <integer> <unit>
              [--keep-daily-for=KEEP_DAILY_FOR]                                # keep one backup per day for <integer> <unit>
              [--keep-weekly-for=KEEP_WEEKLY_FOR]                              # keep one backup per week for <integer> <unit>
              [--keep-monthly-for=KEEP_MONTHLY_FOR]                            # keep one backup per month for <integer> <unit>
              [--keep-yearly-for=KEEP_YEARLY_FOR]                              # keep one backup per year for <integer> <unit>
              [--from-now-keep-hourly-for=FROM_NOW_KEEP_HOURLY_FOR]            # keep one backup per hour for <integer> <unit> calculated from now
              [--from-now-keep-daily-for=FROM_NOW_KEEP_DAILY_FOR]              # keep one backup per hour for <integer> <unit> calculated from now
              [--from-now-keep-weekly-for=FROM_NOW_KEEP_WEEKLY_FOR]            # keep one backup per hour for <integer> <unit> calculated from now
              [--from-now-keep-monthly-for=FROM_NOW_KEEP_MONTHLY_FOR]          # keep one backup per hour for <integer> <unit> calculated from now
              [--from-now-keep-yearly-for=FROM_NOW_KEEP_YEARLY_FOR]            # keep one backup per hour for <integer> <unit> calculated from now

        Remove expired backups from PATH
      OUT
    end

    it 'executes `expire help purge` command successfully' do
      output = `expire help purge`
      expect(output).to eq(expected_output)
    end
  end

  context 'when backups exist' do
    before do
      FileUtils.rm_rf('tmp/backups')
      FileUtils.mkpath('tmp/backups/2021-01-10T22:10')
      FileUtils.mkpath('tmp/backups/2021-01-12T22:10')
      FileUtils.mkpath('tmp/backups/2021-01-14T22:11')
    end

    after { FileUtils.rm_rf('tmp/backups') }

    describe '`expire purge backups --format expired --keep-most-recent-for 2 days' do
      command = 'expire purge tmp/backups --format expired --keep-most-recent-for "2 days"'

      let(:expected_output) do
        <<~OUT
          tmp/backups/2021-01-10T22:10
          tmp/backups/2021-01-12T22:10
          OK
        OUT
      end

      it "executes the `#{command}` command successfully" do
        output = `#{command}`
        expect(output).to eq(expected_output)
      end

      it 'keeps the expected backup' do
        `#{command}`
        kept_backup = Pathname.new('tmp/backups/2021-01-14T22:11')
        expect(kept_backup).to exist
      end

      it 'removes the expired backups' do
        `#{command}`
        backup_dir = Pathname.new('tmp/backups')
        expect(backup_dir.children.length).to eq(1)
      end
    end

    describe '`expire purge backups --keep-most-recent=none`' do
      command = 'expire purge tmp/backups --keep-most-recent=none'

      it "executes `#{command}` successfully" do
        output = `#{command}`
        expect(output).to match(/Will not delete all backups/)
      end
    end
  end

  context 'without any backups' do
    before { FileUtils.mkpath('tmp/backups') }

    after { FileUtils.rm_rf('/tmp/backups') }

    describe '`expire purge backups --format expired --keep-most-recent-for 2 days' do
      command = 'expire purge tmp/backups --format expired --keep-most-recent-for "2 days"'

      it 'complains about missing backups' do
        output = `#{command}`
        expect(output).to match(/Can't find any backups/)
      end

      it 'exits with status 1' do
        `#{command}`
        expect($CHILD_STATUS.exitstatus).to eq(1)
      end
    end
  end

  context 'when the backups directory does not exist' do
    describe '`expire purge no/such/backups --format expired --keep-most-recent-for 2 days' do
      command = 'expire purge no/such/backups --format expired --keep-most-recent-for "2 days"'

      it 'complains about missing backups' do
        output = `#{command}`
        expect(output).to match(%r{no/such/backups})
      end

      it 'exits with status 1' do
        `#{command}`
        expect($CHILD_STATUS.exitstatus).to eq(1)
      end
    end
  end
end
