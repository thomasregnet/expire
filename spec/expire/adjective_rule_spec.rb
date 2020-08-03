# frozen_string_literal: true

require 'support/shared_examples_for_rules'

RSpec.describe Expire::AdjectiveRule do
  subject { described_class.new(amount: 3) }

  describe 'adjective' do
    let(:instance) { described_class.new(amount: 3) }

    context 'when the class-name does not contain a valid adjective' do
      it 'returns nil' do
        expect(instance.adjective).to be_nil
      end
    end
  end

  describe '#spacing' do
    let(:instance) { described_class.new(amount: 3) }

    context 'when the class-name does not contain a valid adjective' do
      it 'returns nil' do
        expect(instance.spacing).to be_nil
      end
    end

    nouns_for = {
      'hourly' => 'hour',
      'daily' => 'day',
      'weekly' => 'week',
      'monthly' => 'month',
      'yearly' => 'year'
    }

    nouns_for.each do |adjective, noun|
      context "with a class-name containing \"#{adjective}\"" do
        before do
          allow(instance)
            .to receive(:class_name)
            .and_return("Hello::My#{adjective.capitalize}Rule")
        end

        it "returns \"#{noun}\"" do
          expect(instance.spacing).to eq(noun)
        end
      end
    end
  end
end
