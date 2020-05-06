# frozen_string_literal: true

module Expire
  # Common used constants
  module Constants
    STEP_WIDTHS = [
      %w[hour hourly].freeze,
      %w[day daily].freeze,
      %w[week weekly].freeze,
      %w[month monthly].freeze,
      %w[year yearly].freeze
    ].freeze
  end
end
