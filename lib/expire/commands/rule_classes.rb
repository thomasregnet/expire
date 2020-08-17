# frozen_string_literal: true

require_relative '../command'

module Expire
  module Commands
    class RuleClasses < Expire::Command
      def initialize(_)
      end

      def execute(output: $stdout)
        Expire.rule_classes.each do |rule_class|
          output.puts rule_class
        end
      end
    end
  end
end
