# frozen_string_literal: true

RSpec.shared_examples 'a keep service' do
  subject do
    described_class.new(
      adjective: :sunny,
      backups:   :fake_backups,
      noun:      :sun,
      rules:     :fake_rules
    )
  end

  it 'responds to .call' do
    expect(described_class).to respond_to(:call)
  end

  it { should respond_to(:adjective) }
  it { should respond_to(:backups) }
  it { should respond_to(:noun) }
  it { should respond_to(:rules) }
end
