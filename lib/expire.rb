# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext'
require 'active_support/core_ext/date_and_time/calculations'
require 'date'
require 'expire/audited_backup'
require 'expire/backup'
require 'expire/backup_list'
require 'expire/constants'
require 'expire/calculate_service_base'
require 'expire/calculate_adjective_service_base'
require 'expire/calculate_adjective_service'
require 'expire/calculate_adjective_for_service_base'
require 'expire/calculate_adjective_for_service'
require 'expire/calculate_service'
require 'expire/calculate_adjective_for_from_now_service'
require 'expire/format_base'
require 'expire/from_directory_service'
require 'expire/null_format'
require 'expire/expired_format'
require 'expire/enhanced_format'
require 'expire/keep_format'
require 'expire/playground'
require 'expire/simple_format'
require 'expire/result'
require 'expire/rule_base'
require 'expire/spacing_rule'
require 'expire/one_per_spacing_rule'
require 'expire/rules'
require 'expire/new_rules'
require 'expire/version'
require 'expire/unknown_rule_error'

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
    FromDirectoryService.call(path).latest_one
  end

  def self.oldest(path)
    FromDirectoryService.call(path).oldest_one
  end

  def self.purge(path, options)
    # format = options[:format]
    # format = format == 'simple' ? SimpleFormat.new : NullFormat.new
    format = format_for(options)

    rules_file = options[:rules_file] || return
    rules = Rules.from_yaml(rules_file)

    FromDirectoryService.call(path).apply(rules).purge(format)
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
