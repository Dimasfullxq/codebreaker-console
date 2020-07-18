# frozen_string_literal: true

RSpec.describe Finisher do
  let(:finisher) { described_class.new }

  describe '#agree?' do
    it 'returns true' do
      allow(finisher).to receive(:gets).and_return('y')
      expect(finisher.agree?('Hello')).to eq(true)
    end

    it 'returns false' do
      allow(finisher).to receive(:gets).and_return('n')
      expect(finisher.agree?('Hello')).to eq(false)
    end

    it 'prompts to enter correct command and returns true' do
      allow(finisher).to receive(:gets).and_return('ff', 'y')
      expect(finisher.agree?('Hello')).to eq(true)
    end
  end
end
