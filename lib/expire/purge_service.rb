# frozen_string_literal: true

module Expire
  # Purge expired backups
  class PurgeService
    def self.call(path, options)
      new(path, options).call
    end

    def initialize(path, options)
      @options = options
      @path    = path
    end

    attr_reader :options, :path

    def call
      check_preconditions
      purge_expired_backups
    rescue StandardError => e
      report.error(e.message)
      raise
    end

    private

    def annotated_backup_list
      @annotated_backup_list ||= rules.apply(GenerateBackupListService.call(path), DateTime.now)
    end

    def check_preconditions
      raise NoRulesError, 'Will not purge without rules' unless rules.any?
      raise AllBackupsExpiredError, 'Will not delete all backups' if annotated_backup_list.keep_count < 1
    end

    def report
      @report ||= report_class.new
    end

    def report_class
      wanted_format = options[:format]

      return ReportNull unless wanted_format
      return ReportNull if wanted_format == 'none'

      class_name = "::Expire::Report#{wanted_format.titleize}"
      class_name.safe_constantize or raise ArgumentError, "unknown format \"#{wanted_format}\""
    end

    def merge_rules
      rules_file = options[:rules_file]
      file_rules = rules_file ? Rules.from_yaml(rules_file) : Rules.new

      option_rules = Rules.from_options(options.transform_keys(&:to_sym))
      file_rules.merge(option_rules)
    end

    def purge_expired_backups
      annotated_backup_list.sort.each do |backup|
        if backup.expired?
          report.before_purge(backup)
          purge_pathname(backup.pathname)
          report.after_purge(backup)
        else
          report.on_keep(backup)
        end
      end
    end

    def purge_pathname(pathname)
      return if options[:simulate]

      purge_command = options[:purge_command]

      if purge_command
        system("#{purge_command} #{pathname}")
      else
        pathname.unlink
      end
    end

    def rules
      @rules ||= merge_rules
    end
  end
end
