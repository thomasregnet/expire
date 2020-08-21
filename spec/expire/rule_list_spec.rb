# frozen_string_literal: true

RSpec.describe Expire::RuleList do
  describe '.class_names' do
    it 'returns an Array' do
      expect(described_class.class_names).to be_instance_of(Array)
    end
  end
end
