# frozen_string_literal: true

module Expire
  # Calculate expiration until
  class KeepFirstOfIntervalUntilService < KeepBase
    include Constants

    def initialize(now:, **args)
      super(args)
      @now = now
    end

    attr_reader :now

    def call
      STEP_WIDTHS.each do |noun, adjective|
        deadline = deadline_for(adjective)
        next unless deadline

        message = "keep all #{adjective} until #{deadline}"

        add_reasons_to_keep(backups.one_per(noun), message, deadline)
      end
    end

    def deadline_for(adjective)
      rule = "#{adjective}_for"
      amount = rules.send rule
      return unless amount

      num, duration = amount.split(/[^a-zA-Z0-9]/)

      now - num.to_i.send(duration)
    end

    private

    def add_reasons_to_keep(thinned_out_backups, message, deadline)
      thinned_out_backups.each do |backup|
        backup.add_reason_to_keep(message) if backup >= deadline
      end
    end
  end
end
