# frozen_string_literal: true

require 'support/shared_examples_for_calculate_service_base_classes'

RSpec.describe Expire::CalculateServiceBase do
  subject { described_class.new(backups: :fake_backups, rules: :fake_rules) }

  it_behaves_like 'a CalculateServiceBase class'

  describe '#call' do
    let(:base) do
      described_class.new(backups: :fake_backups, rules: :fake_rules)
    end

    it 'raises a NotImplementedError' do
      expect { base.call }
        .to raise_error(
          NotImplementedError,
          "#call not implemented in #{described_class}"
        )
    end
  end

  describe '.call' do
    let(:args) { { backups: :fake_backups, rules: :fake_rules } }

    it 'raises a NotImplementedError' do
      expect { described_class.call(args) }
        .to raise_error(
          NotImplementedError,
          "#call not implemented in #{described_class}"
        )
    end
  end
end
