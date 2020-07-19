# frozen_string_literal: true

RSpec.describe GameAdapter do
  let(:console) { Console.new }
  let(:game_adapter) { described_class.new(console) }
  let(:game) { Codebreaker::Game.new(Codebreaker::Player.new('Dima'), 'easy') }
  let(:finisher) { game_adapter.instance_variable_get(:@finisher) }

  describe '.initialize' do
    it 'has finisher field' do
      expect(game_adapter.instance_variables.include?(:@finisher)).to be(true)
    end

    it 'has finisher that is Finisher class' do
      expect(game_adapter.instance_variable_get(:@finisher).class).to eq(Finisher)
    end

    it 'has console field' do
      expect(game_adapter.instance_variables.include?(:@console)).to be(true)
    end

    it 'has console that is Console class' do
      expect(game_adapter.instance_variable_get(:@console).class).to eq(Console)
    end
  end

  describe '#enter_guess' do
    it "returns 'hint' if 'hint' entered" do
      allow(game_adapter).to receive(:gets).and_return('hint')
      expect(game_adapter.enter_guess(game)).to eq('hint')
    end

    it 'returns srting of integer' do
      allow(game_adapter).to receive(:gets).and_return('1234')
      expect(game_adapter.enter_guess(game)).to eq('1234')
    end

    it 'prompts to enter correct code' do
      allow(game_adapter).to receive(:gets).and_return('12345')
      expect(game_adapter).to receive(:alert_input_error)
      game_adapter.enter_guess(game)
    end
  end

  describe '#check_set' do
    it "returns integer if 'hint' was entered" do
      expect(game_adapter.check_set(game, 'hint').class).to eq(Integer)
    end

    it 'prompts there is no hints left if hints count equal to zero' do
      game.instance_variable_set(:@hints, 0)
      expect(game_adapter.check_set(game, 'hint')).to eq('You have no hints left')
    end

    it 'returns string that includes markers when input is valid' do
      expect(game_adapter.check_set(game, '1234')).to match(/['+''-'' ']/)
    end

    it 'returns string with 4 chars when input is valid' do
      expect(game_adapter.check_set(game, '1333').size).to eq(4)
    end
  end

  describe '#win' do
    it 'wins a game and leaves' do
      game.instance_variable_set(:@secret_code, 1234)
      allow(finisher).to receive(:agree?).and_return(false)
      expect(Console).to receive(:leave_the_game)
      game_adapter.win(game, '1234')
    end
  end

  describe '#lose' do
    it 'loses a game and leaves' do
      allow(finisher).to receive(:agree?).and_return(false)
      expect(Console).to receive(:leave_the_game)
      game_adapter.lose(game)
    end

    it 'loses game and starts new one' do
      allow(finisher).to receive(:agree?).and_return(true)
      expect(console).to receive(:start)
      game_adapter.lose(game)
    end
  end
end
