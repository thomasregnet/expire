# frozen_string_literal: true

module Expire
  # Keep hourly|daily|weekly|monthly|yearly backups from now
  #     KeepIntervalForFromNowService
  class KeepIntervalForFromNowService < KeepFirstOfIntervalUntilService
    def rule
      "#{adjective}_for_from_now"
    end
  end
end
