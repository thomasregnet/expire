# frozen_string_literal: true

require 'expire'
require 'thor'

module Expire
  # Command line interface
  class CLI < Thor
    desc 'purge', 'purge expired backups'
    def purge
      # puts '2020-05-23-12-13'
      # TODO: use real rules
      rules = Expire::Rules.new(at_least: 3)
      courier = Expire::SimpleCourier.new

      Expire.directory('backups').apply(rules).purge(courier)
    end
  end
end
