# frozen_string_literal: true

RSpec.shared_examples 'an #apply on a rule' do
  it 'keeps the expected backups' do
    subject.apply(backups, reference_datetime)
    expect(backups.keep).to contain_exactly(*kept)
  end
end
