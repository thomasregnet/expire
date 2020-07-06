# frozen_string_literal: true

require 'expire'
require 'fileutils'

Given('the backup directory exists') do
  @backup_path = Pathname.new('tmp/aruba/backups')

  # cleanup
  FileUtils.rm_rf(@backup_path) if @backup_path.exist?
  %w[
    2020-04-28-20-15
    2020-05-26-20-15
    2020-05-27-20-15
    2020-05-28-20-15
    2020-05-28-20-45
  ].each do |backup_dir|
    FileUtils.mkpath("#{@backup_path}/#{backup_dir}")
  end
end
