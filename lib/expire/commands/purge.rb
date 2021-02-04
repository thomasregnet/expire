# frozen_string_literal: true

require_relative '../command'

module Expire
  module Commands
    # Purge expired backups
    class Purge < Expire::Command
      def initialize(path, options)
        @path = path
        @options = options
      end

      attr_reader :path, :options

      def execute(input: $stdin, output: $stdout)
        begin
          Expire.purge(path, options)
        rescue StandardError => _e
          exit 1
        end

        output.puts 'OK'
      end
    end
  end
end
