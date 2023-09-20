# frozen_string_literal: true

require "active_support"
require "active_support/core_ext"
require "active_support/core_ext/date_and_time/calculations"
require "date"
require "yaml"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect("cli" => "CLI")
loader.setup

# Expire backup directories
module Expire
  # Exception derived from StandardError
  class Error < StandardError; end
  # Your code goes here...

  def self.create_playground(base)
    Playground.create(base)
  end

  def self.newest(path)
    GenerateBackupListService.call(path).newest
  end

  def self.oldest(path)
    GenerateBackupListService.call(path).oldest
  end

  def self.purge(path, options)
    PurgeService.call(path, options)
  end

  def self.remove(path)
    FileUtils.rm_r(path)
  end

  def self.rule_classes
    Expire::RuleList.class_names
  end

  def self.rule_names
    Expire::RuleList.names
  end

  def self.rule_option_names
    Expire::RuleList.option_names
  end
end
