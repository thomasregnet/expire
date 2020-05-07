# frozen_string_literal: true

module Expire
  # Calculate expiration
  class Calculate
    include Constants

    def initialize(backups, rules)
      @backups = backups
      @rules   = rules
    end

    attr_reader :backups, :rules

    def call
      STEP_WIDTHS.each do |noun, adjective|
        accessor = "#{adjective}_to_keep"
        ammount = rules.send accessor
        next unless ammount

        backups.one_per(noun)[0..amount]
      end
    end
  end
end
