# frozen_string_literal: true
require 'expire'
require 'thor'

module Expire
  # Command line interface
  class CLI < Thor

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

    desc 'latest PATH', 'Show the latest backup'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def latest(path)
      if options[:help]
        invoke :help, ['latest']
      else
        require_relative 'commands/latest'
        Expire::Commands::Latest.new(path, options).execute
      end
    end
    # Play with test-data
    class Playground < Thor
      desc 'create PATH', 'play with test-data'
      def create(path)
        Expire.create_playground(path)
      end
    end

    desc 'purge PATH', 'Command description...'
    method_option :help, aliases: '-h', type: :boolean,
      desc: 'Display usage information'
    method_option :format, aliases: '-f', type: :string,
      enum: %w[keep none simple enhanced],
      default: 'none',
      desc: 'output format'
    method_option :rules_file, aliases: '-r', type: :string,
      desc: 'read expire-rules from file'
    def purge(path)
      if options[:help]
        invoke :help, ['purge']
      else
        require_relative 'commands/purge'
        Expire::Commands::Purge.new(path, options).execute
      end
    end

    # desc 'purge', 'purge expired backups'
    # def purge
    #   # puts '2020-05-23-12-13'
    #   # TODO: use real rules
    #   rules = Expire::Rules.new(at_least: 3)
    #   format = Expire::SimpleFormat.new

    #   Expire.directory('backups').apply(rules).purge(format)
    # end

    desc 'playground', 'play with test-data'
    subcommand 'playground', Playground
  end
end
