# frozen_string_literal: true

module Expire
  # Ignore all messages and report nothing
  class ReportNull
    def error(_); end

    def before_all(_); end

    def after_all(_); end

    def on_keep(_); end

    def before_purge(_); end

    def after_purge(_); end
  end
end
