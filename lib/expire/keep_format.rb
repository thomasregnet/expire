# frozen_string_literal: true

module Expire
  class KeepFormat < NullFormat
    def initialize(receiver: $stdout)
        @receiver = receiver
    end

    attr_reader :receiver

    def on_keep(backup)
      receiver.puts backup.path
    end
  end
end
