# frozen_string_literal: true

When('I call Expire.oldest\(path)') do
  @oldest_backup = Expire.oldest('tmp/aruba/backups')
end

Then('I get the oldest backup') do
  expect(@oldest_backup.pathname.to_s).to eq('tmp/aruba/backups/2020-05-23-12-13')
end
