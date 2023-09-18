# frozen_string_literal: true

require_relative "../command"

module Expire
  module Commands
    # Print the names of all rules
    class RuleNames < Expire::Command
      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        Expire.rule_names.each do |rule_name|
          output.puts rule_name
        end
      end
    end
  end
end
