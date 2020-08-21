# frozen_string_literal: true

module Expire
  # Hold backups for a period
  class AdjectiveForRuleBase < FromNowAdjectiveForRuleBase
    ADJECTIVE_FOR = {
      'hour' => 'hourly',
      'day' => 'daily',
      'week' => 'weekly',
      'month' => 'monthly',
      'year' => 'yearly'
    }.freeze

    PRIMARY_RANK = 30

    def apply(backups, _)
      super(backups, backups.newest)
    end

    def primary_rank
      PRIMARY_RANK
    end

    def reason_to_keep
      backup_form = 'backup'.pluralize(amount)
      "keep #{amount} #{ADJECTIVE_FOR[spacing]} #{backup_form}"
    end
  end
end
