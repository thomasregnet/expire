<!-- omit in toc -->
# Expire

**Expire** is a tool for identifying backups that are no longer needed and to delete them.
It can be used either from the command line or as a ruby gem.

<!-- omit in toc -->
## Installation

**The installation is currently not yet possible!**

Add this line to your application's Gemfile:

``` ruby
gem 'expire'
```

And then execute:

``` shell
bundle
```

Or install it yourself as:

``` shell
gem install expire
```

- [Usage](#usage)
- [Purge](#purge)
  - [The `--simulate`, `-s` flag](#the---simulate--s-flag)
  - [The `--format`, `-f` options](#the---format--f-options)
    - [`--format=expired`](#--formatexpired)
    - [`--format=kept`](#--formatkept)
    - [`--format=none`](#--formatnone)
    - [`--format=simple`](#--formatsimple)
    - [`--format=enhanced`](#--formatenhanced)
  - [Rules](#rules)
    - [`--keep-most-recent`](#--keep-most-recent)
    - [`--keep-most-recent-for`](#--keep-most-recent-for)
    - [`--from-now-keep-most-recent-for`](#--from-now-keep-most-recent-for)
    - [Adjectives](#adjectives)
    - [`--keep-<adjective>`](#--keep-adjective)
    - [`--keep-<adjective>-for`](#--keep-adjective-for)
    - [`--from-now-keep-<adjective>-for`](#--from-now-keep-adjective-for)
    - [Time ranges](#time-ranges)
  - [`--rules-file`](#--rules-file)
  - [The `--purge-command`, `--cmd` option](#the---purge-command---cmd-option)
- [How backup timestamps are detected](#how-backup-timestamps-are-detected)
- [Newest](#newest)
- [Oldest](#oldest)
- [Remove](#remove)
- [Rule classes](#rule-classes)
- [Rule names](#rule-names)
- [Rule option names](#rule-option-names)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)

## Usage

The most important command of `expire` is `purge` which is explained first.

## Purge

The `purge` command is used to calculate and delete expired backups.
It is invoked as follows:

``` shell
expire path/to/backups <rules>
```

This would delete, according to the rules, all expired backups under `path/to/backups`.

Before deleting, you may want to know what would be removed.
The `--simulate` option is suitable for this purpose.

### The `--simulate`, `-s` flag

To check the expire-rules you can call `expire purge` with the `--simulate` option:

``` shell
expire path/to/backups <rules> --simulate
```

When `purge` is called this way it will calculate the expired backups
but will not delete anything.

To see what `purge` would delete you have to specify a format, covered in the following section.

### The `--format`, `-f` options

Formats are used to control the output of `expire`.
`expire` supports various formats.
The following examples assume a backup-directory containing some backups:

```shell
backups
├── 2016-01-27T1112
├── 2019-12-24T1200
├── 2021-01-19T1113
├── 2021-01-26T1111
├── 2021-01-27T1111
└── 2021-01-27T1112
```

All `--format`-examples use the `--keep-most-recent=3` rule.
Rules are explained later in this document.

#### `--format=expired`

The **expired** format prints the paths of the expired backups, one per line.

```bash
$ expire purge backups --format=expired --keep-most-recent=3
backups/2016-01-27T1112
backups/2019-12-24T1200
backups/2021-01-19T1113
```

#### `--format=kept`

The **kept** format prints the paths of the kept backups, one per line.

```shell
$ expire purge backups --format=kept --keep-most-recent=3
backups/2021-01-26T1111
backups/2021-01-27T1111
backups/2021-01-27T1112
```

#### `--format=none`

This is the default format, it prints nothing.
Nothing is printed here, so no example.

#### `--format=simple`

The **simple** format prints the path of the kept backups preceded by the work `keeping`
and the expired backups preceded by the word `purged`.

```bash
$ expire purge backups --format=simple --keep-most-recent=3
purged backups/2016-01-27T1112
purged backups/2019-12-24T1200
purged backups/2021-01-19T1113
keeping backups/2021-01-26T1111
keeping backups/2021-01-27T1111
keeping backups/2021-01-27T1112
```

#### `--format=enhanced`

The **enhanced** format works the same way as the simple format.
In addition, it prints the reasons why a backup is kept.

```bash
$ expire purge backups --format=enhanced --keep-most-recent=3
purged backups/2016-01-27T1112
purged backups/2019-12-24T1200
purged backups/2021-01-19T1113
keeping backups/2021-01-26T1111
  reasons:
    - keep the 3 most recent backups
keeping backups/2021-01-27T1111
  reasons:
    - keep the 3 most recent backups
keeping backups/2021-01-27T1112
  reasons:
    - keep the 3 most recent backups
```

### Rules

Rules control which backups to keep and which to discard.
Rules can be specified by command line parameters or in a YAML-file.

You must specify at least one rule or `expire purge` will fail.

#### `--keep-most-recent`

The `--keep-most-recent=3` option preserves the three newest backups from being purged.

```shell
$ expire purge backups --keep-most-recent 3 --format simple
purged backups/2016-01-27T1112
purged backups/2019-12-24T1200
purged backups/2021-01-19T1113
keeping backups/2021-01-26T1111
keeping backups/2021-01-27T1111
keeping backups/2021-01-27T1112
```

#### `--keep-most-recent-for`

Keeps the newest backups for a **time range** specified by *amount* and *unit*.
An *amount* is an integer and a unit is something like *days* or *years*.
Time ranges are discussed in more detail within their own section.

The `--keep-most-recent-for "3 years"` option keeps all backups that are not older than three years.
The **calculation takes the timestamp of the newest backup as reference**.

```shell
$ expire purge backups --keep-most-recent-for "3 years" --format simple
purged backups/2016-01-27T1112
keeping backups/2019-12-24T1200
keeping backups/2021-01-19T1113
keeping backups/2021-01-26T1111
keeping backups/2021-01-27T1111
keeping backups/2021-01-27T1112
```

#### `--from-now-keep-most-recent-for`

The `--from-now-keep-most-recent-for` option works almost the same way as
the `--keep-most-recent-for` option does.
But it **bases its calculation on the current time**, not the timestamp of the newest backup.

Assuming today is the 28th January 2021 the option `--from-now-most-recent-for=5.days`
would act like this:

```shell
$ expire purge backups --from-now-keep-most-recent-for 5.days --format simple 
purged backups/2016-01-27T1112
purged backups/2019-12-24T1200
purged backups/2021-01-19T1113
keeping backups/2021-01-26T1111
keeping backups/2021-01-27T1111
keeping backups/2021-01-27T1112
```

#### Adjectives

The following rules contain an adjective in their name.
These adjectives are *hourly*, *daily*, *weekly*, *monthly* and *yearly*.

#### `--keep-<adjective>`

To keep **one backup per time unit** the *adjective rules* are handy.
There are five adjective rules:

- `--keep-hourly`
- `--keep-daily`
- `--keep-weekly`
- `--keep-monthly`
- `--keep-yearly`

All of these expect an integer that specifies the maximum of backups they should preserve.

```shell
$ expire purge backups --keep-weekly 3 --format=simple
purged backups/2016-01-27T1112
keeping backups/2019-12-24T1200
keeping backups/2021-01-19T1113
purged backups/2021-01-26T1111
purged backups/2021-01-27T1111
keeping backups/2021-01-27T1112
```

You can also use `all` or `-1` to preserve all backups per time unit.

```shell
expire purge backups --keep-yearly all --format=simple
keeping backups/2016-01-27T1112
keeping backups/2019-12-24T1200
purged backups/2021-01-19T1113
purged backups/2021-01-26T1111
purged backups/2021-01-27T1111
keeping backups/2021-01-27T1112
```

#### `--keep-<adjective>-for`

To preserve **one backup per unit for a certain time range** you can use *adjective for rules*.
Time ranges are discussed in more detail within their own section
There are five *adjective-for* rules:

- `--keep-hourly-for`
- `--keep-daily-for`
- `--keep-weekly-for`
- `--keep-monthly-for`
- `--keep-yearly-for`

The **calculation takes the timestamp of the newest backup as reference**.

```shell
$ expire purge backups --keep-daily-for='3 months' --format=simple
purged backups/2016-01-27T1112
purged backups/2019-12-24T1200
keeping backups/2021-01-19T1113
keeping backups/2021-01-26T1111
purged backups/2021-01-27T1111
keeping backups/2021-01-27T1112
```

#### `--from-now-keep-<adjective>-for`

The *from now adjective for rules* work similar to *adjective for rules*,
expect they **base their calculations on the current time**, not the timestamp of the newest backup.

There are five *from now adjective for rules*:

- `--from-now-keep-hourly-for`
- `--from-now-keep-daily-for`
- `--from-now-keep-weekly-for`
- `--from-now-keep-monthly-for`
- `--from-now-keep-yearly-for`

Assuming today is the 28th January 2021 the option `--from-now-most-recent-for=5.days`
would act like this:

```shell
$ expire purge backups --from-now-keep-daily-for='3 months' --format=simple
purged backups/2016-01-27T1112
purged backups/2019-12-24T1200
keeping backups/2021-01-19T1113
keeping backups/2021-01-26T1111
purged backups/2021-01-27T1111
keeping backups/2021-01-27T1112
```

#### Time ranges

Some rules take a time range as argument.
Time ranges can be expressed like this:

```shell
1 hour
2.weeks
3 months
1_000 years
```

As you can see, a range is expressed as a combination of an **integer** and a **unit**.
The integer portion can include underscores (`_`) **between** the digits.
Possible values for the unit portion are:

- `hour` and `hours`
- `day` and `days`
- `week` and `weeks`
- `moth` and `months`
- `year` and `years`

Units are case-insensitive, so `Year` and `yEaR` are valid too.

### `--rules-file`

To read the rules form a YAML-file use the `--rules-file` option.
The rules have to be specified with an underscore instead of a hyphen.

Here is an example rules-file called `rules.yml`:

```yml
keep_most_recent: 3
```

With this rules-file we can `expire` with the `--rules-file` option:

```shell
$ expire purge backups --rules-file rules.yml --format=simple
purged backups/2016-01-27T1112
purged backups/2019-12-24T1200
purged backups/2021-01-19T1113
keeping backups/2021-01-26T1111
keeping backups/2021-01-27T1111
keeping backups/2021-01-27T1112
```

There is also a shortcut for the `--rules-file` option: `-r`.

### The `--purge-command`, `--cmd` option

The `expire` program can remove files and directories,
but it doesn't know how to deal with logical volumes or subvolumes.
This is where the `--purge-command` option comes in.

The `--purge-command` option takes a command as argument.
For each expired backup this command is executed with the backup-path as argument.

```shell
bundle exec exe/expire purge backups --keep-most-recent 3 --format=simple --purge-command='rm -rf'
purged backups/2016-01-27T1112
purged backups/2019-12-24T1200
purged backups/2021-01-19T1113
keeping backups/2021-01-26T1111
keeping backups/2021-01-27T1111
keeping backups/2021-01-27T1112
```

The previous example has called these shell commands:

```shell
rm -rf backups/2016-01-27T1112
rm -rf backups/2019-12-24T1200
rm -rf backups/2021-01-19T1113
```

## How backup timestamps are detected

`expire` recognizes the date of a backup by its file name (or directory name).
This file name must consist of twelve or 14 digits and can optionally contain other characters.
The digits are considered as `YYYYmmddHHMMSS`, where,

- `YYYY` denotes the year of the backup such as `2021`
- `mm` denotes the month the backups was created such as `01` or `11`
- `dd` denotes the day of month such as `07` or `28`
- `HH` denotes the hour (`00`..`23`)
- `MM` denotes the minute
- `SS` denotes the second; seconds are optional

Some valid filenames:

```shell
2021-01-19T1113   # with arbitrary characters
2021-01-19T111345 # with arbitrary characters and seconds
202101191113      # no arbitrary characters
20210119111345    # with seconds and no arbitrary characters
```

Some **invalid** filenames:

```shell
2021-01-19       # just a date, no time
2021-02-31T1113  # February 31
2101191113       # year 2101, only 10 digits
2021011911134501 # 16 digits are too much
```

## Newest

The `newest` command shows the newest backup:

```shell
$ expire newest backups                
backups/2021-01-27T1112
```

## Oldest

The `oldest` command shows the oldest backup:

```shell
$ expire oldest backups          
backups/2016-01-27T1112
```

## Remove

The `remove` command can be used to remove files or directories:

```shell
$ expire remove /tmp/stuff
removed /tmp/stuff
```

## Rule classes

The `rule-classes` command returns a list of all rule-classes:

```shell
$ expire rule-classes
Expire::KeepMostRecentRule
Expire::KeepMostRecentForRule
Expire::FromNowKeepMostRecentForRule
Expire::KeepHourlyRule
Expire::KeepDailyRule
Expire::KeepWeeklyRule
Expire::KeepMonthlyRule
Expire::KeepYearlyRule
Expire::KeepHourlyForRule
Expire::KeepDailyForRule
Expire::KeepWeeklyForRule
Expire::KeepMonthlyForRule
Expire::KeepYearlyForRule
Expire::FromNowKeepHourlyForRule
Expire::FromNowKeepDailyForRule
Expire::FromNowKeepWeeklyForRule
Expire::FromNowKeepMonthlyForRule
Expire::FromNowKeepYearlyForRule
```

## Rule names

The `rule-names` command shows a list of all rule-names:

```shell
$ expire rule-names
keep_most_recent
keep_most_recent_for
from_now_keep_most_recent_for
keep_hourly
keep_daily
keep_weekly
keep_monthly
keep_yearly
keep_hourly_for
keep_daily_for
keep_weekly_for
keep_monthly_for
keep_yearly_for
from_now_keep_hourly_for
from_now_keep_daily_for
from_now_keep_weekly_for
from_now_keep_monthly_for
from_now_keep_yearly_for
```

## Rule option names

To get a list of all rule option-names call:

```shell
$ expire rule-option-names
--keep-most-recent
--keep-most-recent-for
--from-now-keep-most-recent-for
--keep-hourly
--keep-daily
--keep-weekly
--keep-monthly
--keep-yearly
--keep-hourly-for
--keep-daily-for
--keep-weekly-for
--keep-monthly-for
--keep-yearly-for
--from-now-keep-hourly-for
--from-now-keep-daily-for
--from-now-keep-weekly-for
--from-now-keep-monthly-for
--from-now-keep-yearly-for
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on
GitHub at [thomasregnet/expire](https://github.com/thomasregnet/expire.)

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
