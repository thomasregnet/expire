# frozen_string_literal: true


Given('there is no playground') do
  @playground_base = 'tmp/aruba/playground'
  pathname = Pathname.new(@playground_base)
  pathname.rmdir if pathname.exist?
end

When('I call Expire.create_playground') do
  Expire.create_playground(@playground_base)
end

Then('a layground is created') do
  backups = Pathname.new("#{@playground_base}/backups")
  expect(backups.children.length).to eq(15)
end