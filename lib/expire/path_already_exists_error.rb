# frozen_string_literal: true

module Expire
  # Thrown if a file or directory exists when it should not
  class PathAlreadyExistsError < StandardError
  end
end
