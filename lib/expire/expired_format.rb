# frozen_string_literal: true

module Expire
  # Print the paths of expired backups
  class ExpiredFormat < ReportBase
    def before_purge(backup)
      receiver.puts backup.path.to_s
    end
  end
end
