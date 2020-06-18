# frozen_string_literal: true

require 'tty-screen'
require 'expire/simple_format'

module Expire
  # Detailed information about what is being kept and why
  class EnhancedFormat < SimpleFormat
    def on_keep(backup)
      receiver.puts(pastel.green("keeping #{backup.path}"))
      receiver.puts '  reasons:'
      backup.reasons_to_keep.each do |reason|
        receiver.puts "    - #{reason}"
      end
    end
  end
end
