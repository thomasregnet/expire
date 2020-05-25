# frozen_string_literal: true

require 'thor'

module Expire
  # Command line interface
  class CLI < Thor
    desc 'purge', 'purge expired backups'
    def purge
      puts 'Nothing usefull here'
    end
  end
end
