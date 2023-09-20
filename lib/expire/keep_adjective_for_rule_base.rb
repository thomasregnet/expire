# frozen_string_literal: true

module Expire
  # Hold backups for a period
  class KeepAdjectiveForRuleBase < FromNowKeepAdjectiveForRuleBase
    ADJECTIVE_FOR = {
      "week" => "weekly",
      "month" => "monthly",
      "year" => "yearly"
    }.freeze

    PRIMARY_RANK = 30

    def self.primary_rank
      PRIMARY_RANK
    end

    def self.rank
      primary_rank + secondary_rank
    end

    def apply(backups, _)
      super(backups, backups.newest)
    end

    def primary_rank
      self.class.primary_rank
    end

    def reason_to_keep
      "keep #{amount} #{ADJECTIVE_FOR[spacing]} #{numerus_backup}"
    end
  end
end
