# frozen_string_literal: true

module Expire
  # Print the paths of expired backups
  class ReportExpired < ReportBase
    def before_purge(backup)
      receiver.puts backup.pathname.to_s
    end
  end
end
