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

  describe '.from_value' do
    context 'with an valid integer' do
      let(:rule) { described_class.from_value(3) }

      it 'uses the integer as amount' do
        expect(rule.amount).to eq(3)
      end
    end

    context 'with the minimum integer -1' do
      let(:rule) { described_class.from_value(-1) }

      it 'has an amount of -1' do
        expect(rule.amount).to eq(-1)
      end
    end

    context 'with an invalid integer' do
      it 'raises an argument error' do
        expect { described_class.from_value(-2) }
          .to raise_error(ArgumentError, 'must be at least -1')
      end
    end

    context 'with the string "55"' do
      let(:rule) { described_class.from_value('55') }

      it 'has an amount of 55' do
        expect(rule.amount).to eq(55)
      end
    end

    context 'with "all" as value' do
      let(:rule) { described_class.from_value('all') }

      it 'has an amount of -1' do
        expect(rule.amount).to eq(-1)
      end
    end

    context 'with "none" as value' do
      let(:rule) { described_class.from_value('none') }

      it 'has an amount of 0' do
        expect(rule.amount).to eq(0)
      end
    end

    context 'with a bad value' do
      it 'raises an ArgumentError' do
        expect { described_class.from_value('bad evil 666') }
          .to raise_error(ArgumentError)
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
