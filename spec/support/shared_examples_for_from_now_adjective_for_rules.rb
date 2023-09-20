# frozen_string_literal: true

RSpec.shared_examples "an from now adjective-for rule" do
  describe "#rank" do
    it "is between 41 and 45" do
      expect(subject.rank).to be_between(41, 45)
    end
  end
end
