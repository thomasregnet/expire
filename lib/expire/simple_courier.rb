# frozen_string_literal: true

require 'pastel'

module Expire
  # Sends "keeping" and "purged" to it's receiver
  class SimpleCourier < NullCourier
    def initialize(receiver: $stdout)
      @receiver = receiver

      @pastel = Pastel.new
    end

    attr_reader :pastel, :receiver

    def on_keep(backup)
      receiver.puts(pastel.green("keeping #{backup.path}"))
    end

    def after_purge(backup)
      receiver.puts(pastel.red("purged #{backup.path}"))
    end
  end
end
