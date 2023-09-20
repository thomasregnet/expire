# frozen_string_literal: true

require_relative "../command"

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
        Expire.purge(path, options)
      rescue => _e
        exit 1
      end
    end
  end
end
