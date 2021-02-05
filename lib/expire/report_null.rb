# frozen_string_literal: true

module Expire
  # Ignores all messages expect #error and report nothing.
  # When error is received the message is printed to STDOUT.
  class ReportNull
    # def error(_); end
    def error(message)
      puts message
    end

    def before_all(_); end

    def after_all(_); end

    def on_keep(_); end

    def before_purge(_); end

    def after_purge(_); end
  end
end
