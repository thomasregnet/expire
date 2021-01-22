# Expire

**Expire** is a tool for identifying backups that are no longer needed and to delete them.
It can be used either from the command line or as a ruby gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'expire'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install expire

## Usage

TODO: Write usage instructions here

## Rules

Rules control which backups to keep and which to discard.
Rules can be specified by command line parameters or in a yaml-file.

### Most recent rules

There are three  _most recent_ rules, `--most-recent`, `--most-recent-for` and `--from-now-most-recent-for`.

#### --most-recent amount

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
