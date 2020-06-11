# frozen_string_literal: true

When('I call Expire.latest\(path)') do
  @latest_backup = Expire.latest('tmp/aruba/backups')
end

Then("I get the latest backup") do
  expect(@latest_backup.path.to_s).to eq('tmp/aruba/backups/2020-05-25-12-13')
end
