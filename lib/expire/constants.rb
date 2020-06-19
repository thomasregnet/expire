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

    STEP_NOUNS = STEP_WIDTHS.map { |_, noun| noun }.freeze

    NOUN_FOR = STEP_WIDTHS.to_h.freeze
  end
end
