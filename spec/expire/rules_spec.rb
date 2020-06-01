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

  it { should respond_to(:hourly_for_from_now) }
  it { should respond_to(:daily_for_from_now) }
  it { should respond_to(:weekly_for_from_now) }
  it { should respond_to(:monthly_for_from_now) }
  it { should respond_to(:yearly_for_from_now) }

  describe '.new' do
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

  describe '.from_yaml' do
    context 'with a file containing valid rules' do
      let(:file) { 'example_rules/good_rules.yml' }

      it 'returns the Rules' do
        expect(described_class.from_yaml(file))
          .to be_instance_of(described_class)
      end

      it 'has set the rules' do
        rules = described_class.from_yaml(file)

        expect(rules.monthly).to eq(5)
      end
    end

    context 'with a file containing invalid rules' do
      let(:file) { 'example_rules/bad_rules.yml' }

      it 'raises an error' do
        expect { described_class.from_yaml(file) }
          .to raise_error(NoMethodError, /undefined method/)
      end
    end
  end
end
