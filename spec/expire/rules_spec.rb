# frozen_string_literal: true

RSpec.describe Expire::Rules do
  it { should respond_to(:at_least) }

  it { should respond_to(:hourly) }
  it { should respond_to(:daily) }
  it { should respond_to(:weekly) }
  it { should respond_to(:monthly) }
  it { should respond_to(:yearly) }

  it { should respond_to(:hourly_for) }
  it { should respond_to(:daily_for) }
  it { should respond_to(:weekly_for) }
  it { should respond_to(:monthly_for) }
  it { should respond_to(:yearly_for) }

  describe '#new' do
    context 'with a hash' do
      it 'sets the parameters' do
        rules = described_class.new(hourly: 123)
        expect(rules.hourly).to eq(123)
      end
    end

    context 'with a block' do
      it 'yields itself' do
        rules = described_class.new do |keep|
          keep.hourly = 123
        end

        expect(rules.hourly).to eq(123)
      end
    end
  end
end
