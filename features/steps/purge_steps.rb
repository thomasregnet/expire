# frozen_string_literal: true

When("I call Expire.purge with the rules_file option") do
  Expire.purge('tmp/aruba/backups', rules_file: 'tmp/aruba/rules.yml')
end

