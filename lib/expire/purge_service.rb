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
      reference_datetime = DateTime.now

      if options[:purge_command]
        purge_with_command(reference_datetime)
      else
        rules.apply(backups, reference_datetime).purge(format)
      end
    end

    private

    def backups
      FromDirectoryService.call(path)
    end

    def format
      return NullFormat.new unless wanted_format
      return NullFormat.new if wanted_format == 'none'

      begin
        "::Expire::#{wanted_format.titleize}Format".constantize.new
      rescue NameError
        raise ArgumentError, "unknown format \"#{wanted_format}\""
      end
    end

    def purge_with_command(reference_datetime)
      rules.apply(backups, reference_datetime).purge(format) do |backup|
        system("#{options[:purge_command]} #{backup.path}")
      end
    end

    def rules
      rules_file = options[:rules_file]
      file_rules = rules_file ? Rules.from_yaml(rules_file) : Rules.new

      option_rules = Rules.from_options(options.transform_keys(&:to_sym))
      file_rules.merge(option_rules)
    end

    def wanted_format
      @wanted_format ||= options[:format]
    end
  end
end
