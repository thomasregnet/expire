# frozen_string_literal: true

require 'forwardable'

module Expire
  # All Backups go here
  class Backups
    include Enumerable
    extend Forwardable

    def initialize(backups = [])
      # @backups = backups.sort.reverse
      @backups = backups
    end

    attr_reader :backups

    def_delegators :backups, :each, :last, :length, :<<

    def one_per(noun)
      return [] unless any?

      reversed = sort.reverse

      result = [reversed.first]

      message = "same_#{noun}?"

      reversed.each do |backup|
        result << backup unless backup.send(message, result.last)
      end

      result
    end

    def apply(rules)
      CalculateService.call(backups: self, rules: rules)
    end

    def most_recent(amount = 1)
      self.class.new(sort.reverse.first(amount))
    end

    def latest_one
      backups.max
    end

    def oldest_one
      backups.min
    end

    # Enumerable#reverse returns an array but we need a BackupList
    def reverse
      self.class.new(backups.reverse)
    end

    # Enumerable#sort returns an array but we need a BackupList
    def sort
      self.class.new(backups.sort)
    end

    def to_audited_backup_list
      self.class.new(map { |backup| AuditedBackup.new(backup) })
    end

    def expired
      # backups.select(&:expired?)
      backups.select(&:expired?)
    end

    def expired_count
      expired.length
    end

    def keep
      backups.select(&:keep?)
    end

    def keep_count
      keep.length
    end

    def purge(format)
      # expired.each { |backup| FileUtils.rm_rf(backup.id) }
      each do |backup|
        if backup.expired?
          format.before_purge(backup)
          FileUtils.rm_rf(backup.path)
          format.after_purge(backup)
        else
          format.on_keep(backup)
        end
      end
    end
  end
end
