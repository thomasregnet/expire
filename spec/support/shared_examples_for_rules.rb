# frozen_string_literal: true

RSpec.shared_examples 'a rule' do
  it { should respond_to(:amount) }

  describe 'rank' do
    it "has a rank of " do
      expect(subject.rank).to eq(rank)
    end
  end
end
