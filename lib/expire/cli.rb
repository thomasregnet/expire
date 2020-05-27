# frozen_string_literal: true

require 'thor'

module Expire
  # Command line interface
  class CLI < Thor
    desc 'purge', 'purge expired backups'
    def purge
      puts '2020-05-23-12-13'
    end
  end
end
