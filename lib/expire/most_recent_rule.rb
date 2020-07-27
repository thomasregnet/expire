# frozen_string_literal: true

module Expire
  # Keep the most recent Backups
  class MostRecentRule < Rule
    def self.from_value(value)
      new(amount: Integer(value))
    end

    def apply(backups)
      backups.most_recent(amount).each do |backup|
        backup.add_reason_to_keep(reason_to_keep)
      end
    end

    private

    def reason_to_keep
      return 'keep the most recent backup' if amount == 1

      "keep the #{amount} most recent backups"
    end
  end
end
