# frozen_string_literal: true

# For some unknown reason Pastel is not autoloaded by Zeitwerk
require 'pastel'

module Expire
  # Base class for Reporters
  class ReportBase < ReportNull
    def initialize(receiver: $stdout)
      @receiver = receiver
    end

    attr_reader :receiver

    def error(message)
      receiver.puts(pastel.red(message))
    end

    def pastel
      @pastel ||= ::Pastel.new
    end
  end
end
