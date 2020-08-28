# frozen_string_literal: true

RSpec.describe '`expire purge` command', type: :cli do
  it 'executes `expire help purge` command successfully' do
    output = `expire help purge`
    expected_output = <<~OUT
      Usage:
        expire purge PATH

      Options:
        -h, [--help], [--no-help]                                  # Display usage information
        -f, [--format=FORMAT]                                      # output format
                                                                   # Default: none
                                                                   # Possible values: expired, keep, none, simple, enhanced
        --cmd, [--purge-command=PURGE_COMMAND]                     # run command to purge the backup
        -r, [--rules-file=RULES_FILE]                              # read expire-rules from file
            [--most-recent=MOST_RECENT]                            # keep the <integer> most recent backups
            [--most-recent-for=MOST_RECENT_FOR]                    # keep the most recent backups for <integer> <unit>
            [--from-now-most-recent-for=FROM_NOW_MOST_RECENT_FOR]  # keep the most recent backups for <integer> <unit> calculated from now
            [--hourly=HOURLY]                                      # keep the <integer> most recent backups from different hours
            [--daily=DAILY]                                        # keep the <integer> most recent backups from different days
            [--weekly=WEEKLY]                                      # keep the <integer> most recent backups from different weeks
            [--monthly=MONTHLY]                                    # keep the <integer> most recent backups from different months
            [--yearly=YEARLY]                                      # keep the <integer> most recent backups from different years
            [--hourly-for=HOURLY_FOR]                              # keep one backup per hour for <integer> <unit>
            [--daily-for=DAILY_FOR]                                # keep one backup per day for <integer> <unit>
            [--weekly-for=WEEKLY_FOR]                              # keep one backup per week for <integer> <unit>
            [--monthly-for=MONTHLY_FOR]                            # keep one backup per month for <integer> <unit>
            [--yearly-for=YEARLY_FOR]                              # keep one backup per year for <integer> <unit>
            [--from-now-hourly-for=FROM_NOW_HOURLY_FOR]            # keep one backup per hour for <integer> <unit> calculated from now
            [--from-now-daily-for=FROM_NOW_DAILY_FOR]              # keep one backup per hour for <integer> <unit> calculated from now
            [--from-now-weekly-for=FROM_NOW_WEEKLY_FOR]            # keep one backup per hour for <integer> <unit> calculated from now
            [--from-now-monthly-for=FROM_NOW_MONTHLY_FOR]          # keep one backup per hour for <integer> <unit> calculated from now
            [--from-now-yearly-for=FROM_NOW_YEARLY_FOR]            # keep one backup per hour for <integer> <unit> calculated from now

      Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
