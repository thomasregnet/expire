# frozen_string_literal: true

require 'expire'
require 'fileutils'

Given('the backup directory exists') do
  @backup_path = Pathname.new('tmp/backups')

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

When('I run Expire.directory\(path).apply\(rules).purge') do
  Expire.directory(@backup_path.to_s).apply(:rules).purge
end

Then("it purges the expired backups") do
  %w[2020-05-27-20-15 2020-05-28-20-15 2020-05-28-20-45].each do |kept|
    full_path = Pathname.new("#{@backup_path}/#{kept}")
    expect(full_path).to exist
  end

  # TODO: enable the following code to make this test correct
  # %w[2020-04-28-20-15 2020-05-26-20-15].each do |purged|
  #   full_path = Pathname.new("#{@backup_path}/#{purged}")
  #   expect(full_path).not_to exist
  # end
end