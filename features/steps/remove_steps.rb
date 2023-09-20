# frozen_string_literal: true

When('I call Expire.remove\("backups\/bad_backup")') do
  Expire.remove("backups/bad_backup")
rescue Errno::ENOENT => e
  @exception = e
end

Then("an Errno::ENOENT exception is thrown") do
  expect(@exception).to be_instance_of(Errno::ENOENT)
end
