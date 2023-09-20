# frozen_string_literal: true

require_relative "../command"

module Expire
  module Commands
    # Print the newest backup
    class Newest < Expire::Command
      def initialize(path, options)
        @path = path
        @options = options
      end

      attr_reader :path

      def execute(input: $stdin, output: $stdout)
        output.puts Expire.newest(path).pathname
      end
    end
  end
end
