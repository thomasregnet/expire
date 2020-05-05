require 'forwardable'

module Expire
  # All Backups go here
  class BackupList
    include Enumerable
    extend Forwardable

    def initialize(backups = [])
      @backups = backups
    end

    attr_reader :backups
    def_delegators :backups, :each, :<<

    def one_per(interval)
      return [] unless any?

      result = [min]
      message = "same_#{interval}?"

      sort.each do |backup|
        result << backup unless backup.send(message, result.last)
      end

      result
    end
  end
end
