# frozen_string_literal: true

module Expire
  # Sends "keeping" and "purged" to it's receiver
  class SimpleCourier < NullCourier
    def initialize(receiver: $stdout)
      @receiver = receiver
    end

    attr_reader :receiver

    def on_keep(backup)
      receiver.puts("keeping #{backup.id}")
    end

    def after_purge(backup)
      receiver.puts("purged #{backup.id}")
    end
  end
end
