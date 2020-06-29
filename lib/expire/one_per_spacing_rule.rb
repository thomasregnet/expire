# frozen_string_literal: true

module Expire
  # Rules one_per(hour|day|week|month|year)
  class OnePerSpacingRule < SpacingRuleBase
    include Constants

    def apply(backups)
      kept = backups.one_per(spacing).most_recent(amount)
      kept.each { |backup| backup.add_reason_to_keep(reason_to_keep) }
    end

    private

    def reason_to_keep
      adjective = ADJECTIVE_FOR[spacing]
      plural = conditionally_pluralize('backup')

      "keep #{amount} #{adjective} #{plural}"
    end
  end
end
