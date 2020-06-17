# frozen_string_literal: true

require 'expire/colorful'

module Expire
  # Sends "keeping" and "purged" to it's receiver
  class SimpleFormat < NullFormat
    include Colorful

    def initialize(receiver: $stdout)
      @receiver = receiver
    end

    attr_reader :receiver

    def on_keep(backup)
      receiver.puts(pastel.green("keeping #{backup.path}"))
    end

    def after_purge(backup)
      receiver.puts(pastel.yellow("purged #{backup.path}"))
    end
  end
end
