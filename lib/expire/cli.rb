# frozen_string_literal: true

require 'expire'
require 'thor'

module Expire
  # Command line interface
  # rubocop:disable Metrics/ClassLength
  class CLI < Thor
    desc 'rule_option_names', 'List rule option names ordered by their rank'
    method_option(
      :help,
      aliases: '-h',
      type:    :boolean,
      desc:    'Display usage information'
    )
    def rule_option_names(*)
      if options[:help]
        invoke :help, ['rule_option_names']
      else
        require_relative 'commands/rule_option_names'
        Expire::Commands::RuleOptionNames.new(options).execute
      end
    end

    desc 'rule_names', 'List rule names ordered by their rank'
    method_option(
      :help,
      aliases: '-h',
      type:    :boolean,
      desc:    'Display usage information'
    )
    def rule_names(*)
      if options[:help]
        invoke :help, ['rule_names']
      else
        require_relative 'commands/rule_names'
        Expire::Commands::RuleNames.new(options).execute
      end
    end

    desc 'rule_classes', 'List rule classes ordered by their rank'
    method_option(
      :help,
      aliases: '-h',
      type:    :boolean,
      desc:    'Display usage information'
    )
    def rule_classes(*)
      if options[:help]
        invoke :help, ['rule_classes']
      else
        require_relative 'commands/rule_classes'
        Expire::Commands::RuleClasses.new(options).execute
      end
    end

    desc 'remove PATH', 'Remove PATH from the filesystem'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def remove(path)
      if options[:help]
        invoke :help, ['remove']
      else
        require_relative 'commands/remove'
        Expire::Commands::Remove.new(path: path).execute
      end
    end

    desc 'oldest PATH', 'Show the oldest backup'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def oldest(path)
      if options[:help]
        invoke :help, ['oldest']
      else
        require_relative 'commands/oldest'
        Expire::Commands::Oldest.new(path, options).execute
      end
    end

    desc 'newest PATH', 'Show the newest backup'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def newest(path)
      if options[:help]
        invoke :help, ['newest']
      else
        require_relative 'commands/newest'
        Expire::Commands::Newest.new(path, options).execute
      end
    end
    # Play with test-data
    class Playground < Thor
      desc 'create PATH', 'play with test-data'
      def create(path)
        Expire.create_playground(path)
      end
    end

    desc 'purge PATH', 'Remove expired backups from PATH'
    method_option :help, aliases: '-h', type: :boolean,
      desc: 'Display usage information'
    method_option :format, aliases: '-f', type: :string,
      enum: %w[expired keep none simple enhanced],
      default: 'none',
      desc: 'output format'
    method_option :purge_command, aliases: '--cmd', type: :string,
      desc: 'run command to purge the backup'
    method_option :rules_file, aliases: '-r', type: :string,
      desc: 'read expire-rules from file'
    method_option :simulate, aliases: '-s', type: :boolean,
      desc: 'Simulate purge, do not delete anything'
    method_option(
      :most_recent,
      type: :string,
      desc: 'keep the <integer> most recent backups'
    )
    method_option(
      :most_recent_for,
      type: :string,
      desc: 'keep the most recent backups for <integer> <unit>'
    )
    method_option(
      :from_now_most_recent_for,
      type: :string,
      desc: 'keep the most recent backups for <integer> <unit> calculated from now'
    )
    method_option(
      :hourly,
      type: :string,
      desc: 'keep the <integer> most recent backups from different hours'
    )
    method_option(
      :daily,
      type: :string,
      desc: 'keep the <integer> most recent backups from different days'
    )
    method_option(
      :weekly,
      type: :string,
      desc: 'keep the <integer> most recent backups from different weeks'
    )
    method_option(
      :monthly,
      type: :string,
      desc: 'keep the <integer> most recent backups from different months'
    )
    method_option(
      :yearly,
      type: :string,
      desc: 'keep the <integer> most recent backups from different years'
    )
    method_option(
      :hourly_for,
      type: :string,
      desc: 'keep one backup per hour for <integer> <unit>'
    )
    method_option(
      :daily_for,
      type: :string,
      desc: 'keep one backup per day for <integer> <unit>'
    )
    method_option(
      :weekly_for,
      type: :string,
      desc: 'keep one backup per week for <integer> <unit>'
    )
    method_option(
      :monthly_for,
      type: :string,
      desc: 'keep one backup per month for <integer> <unit>'
    )
    method_option(
      :yearly_for,
      type: :string,
      desc: 'keep one backup per year for <integer> <unit>'
    )
    method_option(
      :from_now_hourly_for,
      type: :string,
      desc: 'keep one backup per hour for <integer> <unit> calculated from now'
    )
    method_option(
      :from_now_daily_for,
      type: :string,
      desc: 'keep one backup per hour for <integer> <unit> calculated from now'
    )
    method_option(
      :from_now_weekly_for,
      type: :string,
      desc: 'keep one backup per hour for <integer> <unit> calculated from now'
    )
    method_option(
      :from_now_monthly_for,
      type: :string,
      desc: 'keep one backup per hour for <integer> <unit> calculated from now'
    )
    method_option(
      :from_now_yearly_for,
      type: :string,
      desc: 'keep one backup per hour for <integer> <unit> calculated from now'
    )
    def purge(path)
      if options[:help]
        invoke :help, ['purge']
      else
        require_relative 'commands/purge'
        Expire::Commands::Purge.new(path, options).execute
      end
    end

    desc 'playground', 'play with test-data'
    subcommand 'playground', Playground
  end
  # rubocop:enable Metrics/ClassLength
end
