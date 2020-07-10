# frozen_string_literal: true

RSpec.describe Console do
  let(:console) { described_class.new }
  let(:game) { Codebreaker::Game.new(Codebreaker::Player.new('Dima'), 'easy') }

  before do
    allow($stdout).to receive(:write)
    game.instance_variable_set(:@attempts, 1)
  end

  describe '#start' do
    it 'loses the game' do
      allow(console).to receive(:gets).and_return('1234')
      expect(console).to receive(:finish)
      console.start(game)
    end

    it 'wins the game' do
      game.instance_variable_set(:@secret_code, 1234)
      allow(console).to receive(:gets).and_return('1234', 'n')
      allow(console).to receive(:finish).with(GameEnding::START_NEW_GAME_MESSAGE, game)
      expect(console).to receive(:finish)
      console.start(game)
    end

    it 'takes a hint if you have at least one left' do
      allow(console).to receive(:gets).and_return('hint', '1234')
      allow(console).to receive(:finish).with(GameEnding::START_NEW_GAME_MESSAGE, game)
      expect(console).to receive(:finish)
      console.start(game)
    end

    it 'puts error that no hints left' do
      game.instance_variable_set(:@hints, 0)
      allow(console).to receive(:gets).and_return('hint', '1234')
      allow(console).to receive(:finish).with(GameEnding::START_NEW_GAME_MESSAGE, game)
      expect(console).to receive(:finish)
      console.start(game)
    end

    it 'starts new game' do
      allow(console).to receive(:gets).and_return('1234', 'y')
      expect(console).to receive(:new_game).with(game)
      console.start(game)
    end

    it 'prompts to enter y or n' do
      allow(console).to receive(:gets).and_return('1234', 'yes', 'n')
      expect(console).to receive(:exit).and_return(true)
      console.start(game)
    end

    it 'prompts to enter guess again' do
      allow(console).to receive(:gets).and_return('0000', '1234')
      allow(console).to receive(:finish).with(GameEnding::START_NEW_GAME_MESSAGE, game)
      expect(console).to receive(:finish)
      console.start(game)
    end

    it 'saves result after game win' do
      game.instance_variable_set(:@secret_code, 1234)
      allow(console).to receive(:gets).and_return('1234', 'y')
      expect(console).to receive(:continue?).with(GameEnding::SAVE_RESULTS_MESSAGE).and_return(true)
      allow(console).to receive(:continue?).with(GameEnding::START_NEW_GAME_MESSAGE)
      console.start(game)
    end
  end
end
