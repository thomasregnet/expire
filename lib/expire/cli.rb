# frozen_string_literal: true

require 'expire'
require 'thor'

module Expire
  # Command line interface
  class CLI < Thor
    # Play with test-data
    class Playground < Thor
      desc 'create PATH', 'play with test-data'
      def create(path)
        Expire.create_playground(path)
      end
    end

    desc 'purge', 'purge expired backups'
    def purge
      # puts '2020-05-23-12-13'
      # TODO: use real rules
      rules = Expire::Rules.new(at_least: 3)
      courier = Expire::SimpleCourier.new

      Expire.directory('backups').apply(rules).purge(courier)
    end

    desc 'playground', 'play with test-data'
    subcommand 'playground', Playground
  end
end
