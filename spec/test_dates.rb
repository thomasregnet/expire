# frozen_string_literal: true

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
        days.each do |day|
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

  def to_backup_list
    Expire::BackupList.new(
      result.map { |args| Expire::Backup.new(DateTime.new(*args)) }
    )
  end

  private

  def range_for(gizmo)
    gizmo.class == Integer ? gizmo..gizmo : gizmo
  end
end
