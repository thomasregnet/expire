# frozen_string_literal: true


require 'active_support'
require 'active_support/core_ext'
require 'active_support/core_ext/date_and_time/calculations'
require 'date'
require 'yaml'
require 'zeitwerk'

require 'byebug'

loader = Zeitwerk::Loader.for_gem
loader.setup

# Expire backup directories
module Expire
  # Exception derived from StandardError
  class Error < StandardError; end
  # Your code goes here...

  def self.create_playground(base)
    Playground.create(base)
  end

  def self.directory(path)
    FromDirectoryService.call(path)
  end

  def self.latest(path)
    FromDirectoryService.call(path).newest
  end

  def self.oldest(path)
    FromDirectoryService.call(path).oldest
  end

  def self.purge(path, options)
    format = format_for(options)

    rules_file = options[:rules_file] || return

    rules = Rules.from_yaml(rules_file)

    backups = FromDirectoryService.call(path)
    reference_datetime = DateTime.now

    rules.apply(backups, reference_datetime).purge(format)
  end

  def self.format_for(options)
    case options[:format]
    when 'expired'
      ExpiredFormat.new
    when 'keep'
      KeepFormat.new
    when 'simple'
      SimpleFormat.new
    when 'enhanced'
      EnhancedFormat.new
    when 'none'
      NullFormat.new
    else
      NullFormat.new
    end
  end
end
