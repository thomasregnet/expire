# frozen_string_literal: true

require_relative '../command'

module Expire
  module Commands
    class Latest < Expire::Command
      def initialize(path, options)
        @path = path
        @options = options
      end

      attr_reader :path

      def execute(input: $stdin, output: $stdout)
        output.puts Expire.latest(path).path
      end
    end
  end
end
