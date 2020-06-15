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
require 'expire/from_directory_service'
require 'expire/null_courier'
require 'expire/enhanced_courier'
require 'expire/playground'
require 'expire/simple_courier'
require 'expire/result'
require 'expire/rules'
require 'expire/version'

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
    # courier = format == 'simple' ? SimpleCourier.new : NullCourier.new
    courier = courier_for(options)

    rules_file = options[:rules_file] || return
    rules = Rules.from_yaml(rules_file)

    FromDirectoryService.call(path).apply(rules).purge(courier)
  end

  def self.courier_for(options)
    case options[:format]
    when 'simple'
      SimpleCourier.new
    when 'enhanced'
      EnhancedCourier.new
    when 'none'
      NullCourier.new
    else
      NullCourier.new
    end
  end
end
