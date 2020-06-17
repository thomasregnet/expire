# frozen_string_literal: true

require 'pastel'

module Expire
  # pastel for formats
  module Colorful
    def pastel
      @pastel ||= ::Pastel.new
    end
  end
end
