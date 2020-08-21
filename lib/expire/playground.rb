# frozen_string_literal: true

module Expire
  # Create playground with example data
  class Playground
    STEP_WIDTHS = {
      'hourly' => 'hour',
      'daily' => 'day',
      'weekly' => 'week',
      'monthly' => 'month',
      'yearly' => 'year'
    }.freeze

    def self.create(base)
      new(base).create
    end

    def initialize(base)
      @base        = base
      @backups_dir = Pathname.new("#{base}/backups")

      @options = {
        hourly:  42,
        daily:   15,
        weekly:  15,
        monthly: 25,
        yearly:  5
      }
    end

    attr_reader :backups_dir, :base, :options

    def create
      oldest_backup = DateTime.now

      STEP_WIDTHS.each do |adjective, noun|
        options[adjective.to_sym].times do
          oldest_backup = oldest_backup.ago(1.send(noun))
          mkbackup(oldest_backup)
        end
      end
    end

    private

    def mkbackup(datetime)
      backup_name = datetime.to_s.sub(/:\d\d[+-]\d\d:\d\d\z/, '')
      FileUtils.mkdir_p("#{backups_dir}/#{backup_name}")
    end
  end
end
