# frozen_string_literal: true

RSpec.describe Registrator do
  let(:registrator) { described_class.new }

  before do
    allow($stdout).to receive(:write)
  end

  describe '#registrate_game' do
    it 'prompts to enter correct command and creates game object' do
      allow(registrator).to receive(:gets).and_return('Dima', 'easysysyas', 'easy')
      expect(registrator.registrate_game.class).to eq(Codebreaker::Game)
    end

    it 'rescues Error from name validation' do
      allow(registrator).to receive(:gets).and_return('Di')
      allow(registrator).to receive(:create_game)
      expect(registrator).to receive(:alert_input_error).with(Codebreaker::ShortNameError)
      registrator.registrate_game
    end

    it 'rescues Error from difficulty validation' do
      allow(registrator).to receive(:create_player)
      allow(registrator).to receive(:gets).and_return('eaaassysys')
      expect(registrator).to receive(:alert_input_error).with(Codebreaker::WrongCommandError)
      registrator.registrate_game
    end
  end
end
