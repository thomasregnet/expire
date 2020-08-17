# frozen_string_literal: true

require_relative '../command'

module Expire
  module Commands
    # Remove files and directories
    class Remove < Expire::Command
      def initialize(path:)
        @path = path
      end

      attr_reader :path

      def execute(input: $stdin, output: $stdout)
        begin
          FileUtils.rm_r(path)
        rescue Errno::ENOENT => e
          output.puts "can't remove #{path}: #{e}"
          exit 1
        end
        output.puts "removed #{path}"
      end
    end
  end
end
