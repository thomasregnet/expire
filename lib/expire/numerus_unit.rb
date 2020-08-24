# frozen_string_literal: true

module Expire
  # A mixin to get the right numerus of #unit
  module NumerusUnit
    def numerus_unit
      unit.pluralize(amount)
    end
  end
end
