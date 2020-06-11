# frozen_string_literal: true

require_relative '../command'

module Expire
  module Commands
    class Purge < Expire::Command
      def initialize(path, options)
        @path = path
        @options = options
      end

      attr_reader :path, :options

      def execute(input: $stdin, output: $stdout)
        # Command logic goes here ...
        # TODO: use real rules
        rules = Expire::Rules.new(at_least: 3)
        courier = Expire::SimpleCourier.new

        # Expire.directory('backups').apply(rules).purge(courier)
        Expire.directory(path).apply(rules).purge(courier)

        output.puts "OK"
      end
    end
  end
end
