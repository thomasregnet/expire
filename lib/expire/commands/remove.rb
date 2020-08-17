# frozen_string_literal: true

require_relative '../command'

module Expire
  module Commands
    class Remove < Expire::Command
      def initialize(options)
        @options = options
      end

      attr_reader :options

      def execute(input: $stdin, output: $stdout)
        FileUtils.rm_rf(options[:path])
        output.puts "removed #{options[:path]}"
      end
    end
  end
end
