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

      if options[:purge_command]
        purge_with_command
      else
        purge_without_command
      end
    end

    private

    def annotaded_backup_list
      @annotaded_backup_list ||= \
        rules.apply(FromDirectoryService.call(path), DateTime.now)
    end

    def format
      @format ||= format_class.new
    end

    def format_class
      wanted_format = options[:format]

      return NullFormat unless wanted_format
      return NullFormat if wanted_format == 'none'

      class_name = "::Expire::#{wanted_format.titleize}Format"
      class_name.safe_constantize \
        or raise ArgumentError, "unknown format \"#{wanted_format}\""
    end

    def purge_without_command
      annotaded_backup_list.each do |backup|
        if backup.expired?
          format.before_purge(backup)
          FileUtils.rm_rf(backup.path)
          format.after_purge(backup)
        else
          format.on_keep(backup)
        end
      end
    end

    def purge_with_command
      annotaded_backup_list.each do |backup|
        if backup.expired?
          format.before_purge(backup)
          system("#{options[:purge_command]} #{backup.path}")
          format.after_purge(backup)
        else
          format.on_keep(backup)
        end
      end
    end

    def rules
      @rules ||= merge_rules
    end

    def merge_rules
      rules_file = options[:rules_file]
      file_rules = rules_file ? Rules.from_yaml(rules_file) : Rules.new

      option_rules = Rules.from_options(options.transform_keys(&:to_sym))
      file_rules.merge(option_rules)
    end
  end
end
