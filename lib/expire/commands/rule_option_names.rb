# frozen_string_literal: true

require_relative '../command'

module Expire
  module Commands
    class RuleOptionNames < Expire::Command
      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        Expire.rule_option_names.each do |option_name|
          output.puts option_name
        end
      end
    end
  end
end
