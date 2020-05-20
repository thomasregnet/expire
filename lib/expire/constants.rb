# frozen_string_literal: true

module Expire
  # Common used constants
  module Constants
    # STEP_WIDTHS = [
    #   %w[hour hourly].freeze,
    #   %w[day daily].freeze,
    #   %w[week weekly].freeze,
    #   %w[month monthly].freeze,
    #   %w[year yearly].freeze
    # ].freeze
    STEP_WIDTHS = [
      %w[hourly hour].freeze,
      %w[daily day].freeze,
      %w[weekly week].freeze,
      %w[monthly month].freeze,
      %w[yearly year].freeze
    ].freeze

    # STEP_ADJECTIVES = STEP_WIDTHS.map { |_, adjective| adjective }.freeze
    STEP_ADJECTIVES = STEP_WIDTHS.map { |adjective, _| adjective }.freeze
  end
end
