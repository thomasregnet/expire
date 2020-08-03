# frozen_string_literal: true

RSpec.shared_examples 'an adjective rule' do
  describe 'adjective' do
    it 'returns the right adjective' do
      expect(subject.adjective).to eq(adjective)
    end
  end

  describe 'spacing' do
    it 'returns the right spacing' do
      expect(subject.spacing).to eq(spacing)
    end
  end
end
