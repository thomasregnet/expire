# frozen_string_literal: true

module Expire
  # Thrown if all backups are expired
  class AllBackupsExpiredError < StandardError
  end
end
