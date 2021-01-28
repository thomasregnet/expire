# frozen_string_literal: true

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
              [--keep-from-now-most-recent-for=KEEP_FROM_NOW_MOST_RECENT_FOR]  # keep the most recent backups for <integer> <unit> calculated from now
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
              [--keep-from-now-hourly-for=KEEP_FROM_NOW_HOURLY_FOR]            # keep one backup per hour for <integer> <unit> calculated from now
              [--keep-from-now-daily-for=KEEP_FROM_NOW_DAILY_FOR]              # keep one backup per hour for <integer> <unit> calculated from now
              [--keep-from-now-weekly-for=KEEP_FROM_NOW_WEEKLY_FOR]            # keep one backup per hour for <integer> <unit> calculated from now
              [--keep-from-now-monthly-for=KEEP_FROM_NOW_MONTHLY_FOR]          # keep one backup per hour for <integer> <unit> calculated from now
              [--keep-from-now-yearly-for=KEEP_FROM_NOW_YEARLY_FOR]            # keep one backup per hour for <integer> <unit> calculated from now

        Remove expired backups from PATH
      OUT
    end

    it 'executes `expire help purge` command successfully' do
      output = `expire help purge`
      expect(output).to eq(expected_output)
    end
  end

  describe '`expire purge backups --format expired --most-recent-for 2 days' do
    before do
      FileUtils.rm_rf('tmp/backups')
      FileUtils.mkpath('tmp/backups/2021-01-10T22:10')
      FileUtils.mkpath('tmp/backups/2021-01-12T22:10')
      FileUtils.mkpath('tmp/backups/2021-01-14T22:11')
    end

    after { FileUtils.rm_rf('tmp/backups') }

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
end
