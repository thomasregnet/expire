# frozen_string_literal: true

require 'fileutils'

module Expire
  # Create playground with example data
  class Playground
    include Constants

    PLAYGROUND_SIZES = %w[small medium large].freeze

    def self.create(base)
      new(base).create
    end

    def initialize(base)
      @base        = base
      @backups_dir = Pathname.new("#{base}/backups")
    end

    attr_reader :backups_dir, :base

    def create
      oldest_backup = DateTime.now

      STEP_WIDTHS.each do |_, noun|
        3.times do
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
