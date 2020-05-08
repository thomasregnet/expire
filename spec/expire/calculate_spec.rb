# frozen_string_literal: true

require 'test_dates'

RSpec.describe Expire::Calculate do
  let(:td) do
    TestDates.new
  end

  it 'foos' do
    expect(td).not_to be_nil
  end
end
