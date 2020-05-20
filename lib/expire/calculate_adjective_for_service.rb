# frozen_string_literal: true

module Expire
  # Calculate expiration until
  class CalculateAdjectiveForService < CalculateAdjectiveForServiceBase
    def now
      @now ||= backups.max
    end

    def rule
      "#{adjective}_for"
    end
  end
end
