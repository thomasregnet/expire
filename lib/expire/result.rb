# frozen_string_literal: true

require 'forwardable'

module Expire
  # The resulting backup of a calculation
  class Result
    include Enumerable
    extend Forwardable

    def initialize(backups = [])
      @backups = backups
    end

    attr_reader :backups

    def_delegators :backups, :each, :<<

    def expired
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

    def purge(courier)
      # expired.each { |backup| FileUtils.rm_rf(backup.id) }
      each do |backup|
        if backup.expired?
          FileUtils.rm_rf(backup.path)
          courier.after_purge(backup)
        else
          courier.on_keep(backup)
        end
      end
    end
  end
end
