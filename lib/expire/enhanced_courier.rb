# frozen_string_literal: true

require 'pastel'
require 'tty-screen'

module Expire
  # Detailed information about what is being kept and why
  class EnhancedCourier < NullCourier
    def initialize(receiver: $stdout)
      @receiver = receiver

      @pastel = Pastel.new
    end

    attr_reader :pastel, :receiver

    def on_keep(backup)
      receiver.puts(pastel.green("keeping #{backup.path}"))
      receiver.puts '  reasons:'
      backup.reasons_to_keep.each do |reason|
        receiver.puts "    - #{reason}"
      end
    end

    def after_purge(backup)
      receiver.puts(pastel.yellow("purged #{backup.path}"))
    end
  end
end
