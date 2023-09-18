# frozen_string_literal: true

module Expire
  # Enhance Integer and String with the methods #all? and #none?
  module RefineAllAndNone
    refine String do
      def all?
        return true if ["-1", "all"].include?(strip.downcase)
      end

      # %w does not work here, I assume there is a problem with "0"
      # rubocop:disable Style/RedundantPercentQ
      def none?
        return true if %q(0 none).include?(strip.downcase)
      end
      # rubocop:enable Style/RedundantPercentQ
    end

    refine Integer do
      def all?
        return true if self == -1
      end

      def none?
        return true if zero?
      end
    end
  end
end
