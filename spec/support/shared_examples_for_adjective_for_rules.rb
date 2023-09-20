# frozen_string_literal: true

RSpec.shared_examples "an adjective-for rule" do
  describe "#rank" do
    it "is between 31 and 35" do
      expect(subject.rank).to be_between(31, 35)
    end
  end
end
