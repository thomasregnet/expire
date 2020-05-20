# frozen_string_literal: true

require 'support/shared_examples_for_calculate_adjective_for_services'

RSpec.describe Expire::CalculateAdjectiveForServiceBase do
  subject do
    described_class.new(
      adjective: :fake_adjective,
      backups:   :fake_backups,
      noun:      :fake_noun,
      rules:     :fake_rules
    )
  end

  it_behaves_like 'a calculate adjective for service'

  describe '#now' do
    let(:base) do
      described_class.new(
        adjective: :fake_adjective,
        backups:   :fake_backups,
        noun:      :fake_noun,
        rules:     :fake_rules
      )
    end

    it 'raises a NotImplementedError' do
      expect { base.now }
        .to raise_error(
          NotImplementedError,
          "#now not implemented in #{described_class}"
        )
    end
  end

  describe '#rule' do
    let(:base) do
      described_class.new(
        adjective: :fake_adjective,
        backups:   :fake_backups,
        noun:      :fake_noun,
        rules:     :fake_rules
      )
    end

    it 'raises a NotImplementedError' do
      expect { base.rule }
        .to raise_error(
          NotImplementedError,
          "#rule not implemented in #{described_class}"
        )
    end
  end
end
