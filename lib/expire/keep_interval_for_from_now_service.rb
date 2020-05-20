# frozen_string_literal: true

module Expire
  # Keep hourly|daily|weekly|monthly|yearly backups from now
  class KeepIntervalForFromNowService < CalculateAdjectiveForServiceBase
    def initialize(now:, **args)
      super(args)
      @now = now
    end

    attr_reader :now

    def rule
      "#{adjective}_for_from_now"
    end
  end
end
