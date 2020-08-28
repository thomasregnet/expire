# frozen_string_literal: true

require 'last_day_of'

# Generate ranges of dates for testing
# This class smells of :reek:TooManyInstanceVariables
class TestDates
  include Enumerable
  extend Forwardable

  def self.create(args = {})
    new(args).create
  end

  # This method smells of :reek:DuplicateMethodCall
  def initialize(args = {})
    @years   = range_for(args.fetch(:years,     1860))
    @months  = range_for(args.fetch(:months,    5))
    @days    = range_for(args.fetch(:days,      17))
    @hours   = range_for(args.fetch(:hours,     12))
    @minutes = range_for(args.fetch(:minutes,   (0..59).step(60)))

    @result = []
  end

  attr_reader :years, :months, :days, :hours, :minutes, :result
  def_delegators :result, :each

  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:NestedIterators
  # rubocop:disable Metrics/MethodLength
  def create
    years.each do |year|
      months.each do |month|
        days_for(year, month).each do |day|
          hours.each do |hour|
            minutes.each do |minute|
              result << [year, month, day, hour, minute, 0]
            end
          end
        end
      end
    end

    self
  end
  # rubocop:enable Metrics/MethodLength

  def days_for(year, month)
    last_day = year.last_day_of(month)

    days.select { |day| day <= last_day }
  end

  def to_a
    result
  end

  def to_backups
    backups = result.map do |args|
      path = "backups/#{args[0..5].join('_')}"

      Expire::Backup.new(
        datetime: DateTime.new(*args),
        path:     path
      )
    end

    Expire::BackupList.new(backups)
  end

  def to_backup_list
    Expire::BackupList.new(
      # result.map { |args| Expire::Backup.new(DateTime.new(*args)) }
      result.map do |args|
        path = "backups/#{args[0..5].join('_')}"

        Expire::Backup.new(
          datetime: DateTime.new(*args),
          path:     path
        )
      end
    )
  end

  private

  def range_for(gizmo)
    gizmo.class == Integer ? gizmo..gizmo : gizmo
  end
end
