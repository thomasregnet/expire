# frozen_string_literal: true

module Expire
  # Base class for from-now rules
  class FromNowAdjectiveForRule < AdjectiveRule
    def apply(backups, reference_datetime)
      minimal_backup = compareable_fake_backup_for(reference_datetime)

      backups.one_per(spacing).each do |backup|
        next if backup <= minimal_backup

        backup.add_reason_to_keep(reason_to_keep)
      end
    end

    private

    def compareable_fake_backup_for(reference_datetime)
      minimal_datetime = reference_datetime - amount.send(unit)
      fake_backup = Object.new
      fake_backup.define_singleton_method(:datetime) { minimal_datetime }

      fake_backup
    end
  end
end
