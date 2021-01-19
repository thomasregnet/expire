# frozen_string_literal: true

module Expire
  # Detailed information about what is being kept and why
  class ReportEnhanced < ReportSimple
    def on_keep(backup)
      receiver.puts(pastel.green("keeping #{backup.path}"))
      receiver.puts '  reasons:'
      backup.reasons_to_keep.each do |reason|
        receiver.puts "    - #{reason}"
      end
    end
  end
end
