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
require 'expire/result'
require 'expire/rules'
require 'expire/version'

module Expire
  # Exception derived from StandardError
  class Error < StandardError; end
  # Your code goes here...

  def self.directory(path)
    FromDirectoryService.call(path)
  end
end
