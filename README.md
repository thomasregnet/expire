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
It is invoked as follows

``` shell
expire path/to/backups <rules>
```

This would delete, according to the rules, all expired backups under `path/to/backups`.

Before deleting, you may want to know what would be removed.
The `--simulate` option is suitable for this purpose.

### Simulate purge

To check the expire-rules you can call `expire purge` with the `--simulate` option:

``` shell
expire path/to/backups <rules> --simulate
```

When `expire purge` is called this way it will calculate the expired backups
but will not delete anything.

To see what `purge` would delete you have to specify a format, covered in the following section.

### Formats

Formats are used to what's going on during purification.

#### Expired

The **expired** format prints the paths of the expired backups, one per line.

#### kept

The **kept** format prints the paths of the kept backups, one per line.

#### none

This is the default format, it prints nothing.

#### simple

The **simple** format prints the path of the kept backups preceded by the work `keeping`
and the expired backups preceded by the word `purged`.

#### enhanced

The **enhanced** format works the same way as the simple format.
In addition, it prints the reasons why a backup is kept.

## Rules

Rules control which backups to keep and which to discard.
Rules can be specified by command line parameters or in a yaml-file.

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

There are three _most recent_ rules, `--most-recent`, `--most-recent-for` and `--from-now-most-recent-for`.

```shell
$ expire purge backups --most-recent 3 --format simple --simulate
purged backups/2016-01-27T1112
purged backups/2019-12-24T1200
purged backups/2021-01-19T1113
keeping backups/2021-01-26T1111
keeping backups/2021-01-27T1111
keeping backups/2021-01-27T1112
```

#### --most-recent

The `--most-recent` rule takes the amount of last backups to keep.
For example `--most-recent=3` preserves the three newest backups from being purged.

##### --most-recent-for amount unit

Keeps the newest backups for a period of time.
The period of time is specified with the `amount` and `unit` parameters.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/expire.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
