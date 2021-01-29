# Expire

**Expire** is a tool for identifying backups that are no longer needed and to delete them.
It can be used either from the command line or as a ruby gem.

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

## Usage

TODO: Write usage instructions here

## Purge

The purge command is used to calculate and delete the expired backups.
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

When `expire purge` is called this way it will calculate the expired backups
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

All examples use the `--keep-most-recent=3` rule.
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

## Rules

Rules control which backups to keep and which to discard.
Rules can be specified by command line parameters or in a Yaml file.

You must specify at least one rule or `expire purge` will fail.

```shell
backups/2016-01-27T1112
backups/2019-12-24T1200
backups/2021-01-19T1113
backups/2021-01-26T1111
backups/2021-01-27T1111
backups/2021-01-27T1112
```

### Most recent rules

There are three _most recent_ rules, `--keep-most-recent`, `--keep-most-recent-for` and `--from-now-keep-most-recent-for`.

```shell
$ expire purge backups --keep-most-recent 3 --format simple
purged backups/2016-01-27T1112
purged backups/2019-12-24T1200
purged backups/2021-01-19T1113
keeping backups/2021-01-26T1111
keeping backups/2021-01-27T1111
keeping backups/2021-01-27T1112
```

#### --keep-most-recent

The `--keep-most-recent=3` option preserves the three newest backups from being purged.

##### --keep-most-recent-for amount unit

Keeps the newest backups for a period of time.
The period of time is specified with the `amount` and `unit` parameters.

## Time ranges

Some rules take a time range as argument.
Ranges may be expressed like this:

```shell
1 hour
2.weeks
3 months
1_000 years
```

As you can see, a range is expressed as a combination of an **integer** and a **unit**.
The integer portion can include underscores (`_`) **between** the digits.
Possible values for the unit portion are:

* `hour` and `hours`
* `day` and `days`
* `week` and `weeks`
* `moth` and `months`
* `year` and `years`

Units are case-insensitive, so `Year` and `yEaR` are valid too.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on
GitHub at [thomasregnet/expire](https://github.com/thomasregnet/expire.)

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
