# frozen_string_literal: true

module Expire
  # A Courier that discards all messages
  class NullCourier
    def before_all(_); end

    def after_all(_); end

    def on_keep(_); end

    def before_purge(_); end

    def after_purge(_); end
  end
end
