# frozen_string_literal: true

require_relative "../command"

module Expire
  module Commands
    # Print the oldest backup
    class Oldest < Expire::Command
      def initialize(path, options)
        @path = path
        @options = options
      end

      attr_reader :path

      def execute(input: $stdin, output: $stdout)
        output.puts Expire.oldest(path).pathname
      end
    end
  end
end
