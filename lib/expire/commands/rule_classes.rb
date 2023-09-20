# frozen_string_literal: true

require_relative "../command"

module Expire
  module Commands
    # Print all rule-classes
    class RuleClasses < Expire::Command
      # standard:disable Style/RedundantInitialize
      def initialize(_)
      end
      # standard:enable Style/RedundantInitialize

      def execute(output: $stdout)
        Expire.rule_classes.each do |rule_class|
          output.puts rule_class
        end
      end
    end
  end
end
