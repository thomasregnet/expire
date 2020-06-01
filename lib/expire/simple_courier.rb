# frozen_string_literal: true

module Expire
  # Sends "keeping" and "purged" to it's receiver
  class SimpleCourier < NullCourier
    def initialize(receiver: $stdout)
      @receiver = receiver
    end

    attr_reader :receiver

    def on_keep(backup)
      receiver.puts("keeping #{backup.path}")
    end

    def after_purge(backup)
      receiver.puts("purged #{backup.path}")
    end
  end
end
