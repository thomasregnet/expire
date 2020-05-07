# frozen_string_literal: true

module Expire
  # Show if a Backup is expired or not
  class AuditedBackup < Delegator
    include Comparable

    def initialize(backup)
      @backup          = backup
      @reasons_to_keep = []
    end

    attr_reader :backup, :reasons_to_keep
    alias __getobj__ backup

    def add_reason_to_keep(reason)
      reasons_to_keep << reason
    end

    def expired?
      reasons_to_keep.empty?
    end

    def keep?
      reasons_to_keep.any?
    end

    def <=>(other)
      backup <=> other.backup
    end
  end
end
