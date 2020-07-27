# frozen_string_literal: true

RSpec.shared_examples 'an adjective rule' do
  describe 'spacing' do
    it 'returns the right spacing' do
      expect(subject.spacing).to eq(spacing)
    end
  end
end
