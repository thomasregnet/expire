# frozen_string_literal: true

# For some unknown reason Pastel is not autoloaded by Zeitwerk
require 'pastel'

module Expire
  # Base class for formats
  class FormatBase < ReportNull
    def initialize(receiver: $stdout)
      @receiver = receiver
    end

    attr_reader :receiver

    def pastel
      @pastel ||= ::Pastel.new
    end
  end
end
