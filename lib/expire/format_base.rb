# frozen_string_literal: true

require 'expire/null_format'

module Expire
  # Base class for formats
  class FormatBase < NullFormat
    def initialize(receiver: $stdout)
      @receiver = receiver
    end

    attr_reader :receiver
  end
end
