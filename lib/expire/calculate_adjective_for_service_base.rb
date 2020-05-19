# frozen_string_literal: true

module Expire
  # Base class for CalculateAdjectiveFor services
  class CalculateAdjectiveForServiceBase < CalculateAdjectiveServiceBase
    def now
      raise NotImplementedError, "#now not implemented in #{self.class}"
    end
  end
end
