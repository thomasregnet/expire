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
      raise NoRulesError, 'Will not purge without rules' unless rules.any?

      annotated_backup_list.each do |backup|
        if backup.expired?
          format.before_purge(backup)
          purge_pathname(backup.path)
          format.after_purge(backup)
        else
          format.on_keep(backup)
        end
      end
    end

    private

    def annotated_backup_list
      rules.apply(GenerateBackupListService.call(path), DateTime.now)
    end

    def format
      @format ||= format_class.new
    end

    def format_class
      wanted_format = options[:format]

      return ReportNull unless wanted_format
      return ReportNull if wanted_format == 'none'

      class_name = "::Expire::#{wanted_format.titleize}Format"
      class_name.safe_constantize \
        or raise ArgumentError, "unknown format \"#{wanted_format}\""
    end

    def merge_rules
      rules_file = options[:rules_file]
      file_rules = rules_file ? Rules.from_yaml(rules_file) : Rules.new

      option_rules = Rules.from_options(options.transform_keys(&:to_sym))
      file_rules.merge(option_rules)
    end

    def purge_pathname(pathname)
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
