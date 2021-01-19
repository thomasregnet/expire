# frozen_string_literal: true

module Expire
  # Print the backups that are kept
  class KeepFormat < ReportBase
    def on_keep(backup)
      receiver.puts backup.path.to_s
    end
  end
end
