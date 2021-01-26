# frozen_string_literal: true

module Expire
  # Sends "keeping" and "purged" to it's receiver
  class ReportSimple < ReportBase
    def on_keep(backup)
      receiver.puts(pastel.green("keeping #{backup.pathname}"))
    end

    def after_purge(backup)
      receiver.puts(pastel.yellow("purged #{backup.pathname}"))
    end
  end
end
