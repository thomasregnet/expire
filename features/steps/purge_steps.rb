# frozen_string_literal: true

When("I call Expire.purge with the rules_file option") do
  Expire.purge('tmp/aruba/backups', rules_file: 'tmp/aruba/rules.yml')
end


When('I call Expire.purge with the purge-command option') do
  Expire.purge(
    'tmp/aruba/backups',
    purge_command: 'expire remove',
    rules_file:    'tmp/aruba/rules.yml'
  )
end

When('I call Expire.purge with the most_recent option') do
  Expire.purge(
    'tmp/aruba/backups',
    most_recent: 3
  )
end
