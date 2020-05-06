# frozen_string_literal: true

RSpec.describe Expire::Rules do
  it { should respond_to(:hourly_to_keep) }
  it { should respond_to(:daily_to_keep) }
  it { should respond_to(:weekly_to_keep) }
  it { should respond_to(:monthly_to_keep) }
  it { should respond_to(:yearly_to_keep) }

  describe '#new' do
    context 'with a hash' do
      it 'sets the parameters' do
        rules = described_class.new(hourly_to_keep: 123)
        expect(rules.hourly_to_keep).to eq(123)
      end
    end

    context 'with a block' do
      it 'yields itself' do
        rules = described_class.new do |rule|
          rule.hourly_to_keep = 123
        end

        expect(rules.hourly_to_keep).to eq(123)
      end
    end
  end
end
