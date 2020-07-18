# frozen_string_literal: true

RSpec.describe Console do
  let(:console) { described_class.new }
  let(:game) { Codebreaker::Game.new(Codebreaker::Player.new('Dima'), 'easy') }
  let(:game_adapter) { console.instance_variable_get(:@game_adapter) }

  before do
    allow($stdout).to receive(:write)
  end

  describe '.initialize' do
    it 'has game_adapter field' do
      expect(console.instance_variables.include?(:@game_adapter)).to be(true)
    end

    it 'has registrator field' do
      expect(console.instance_variables.include?(:@registrator)).to be(true)
    end

    it 'has registrator that is Registrator class' do
      expect(console.instance_variable_get(:@registrator).class).to eq(Registrator)
    end

    it 'has game_adapter that is GameAdapter class' do
      expect(console.instance_variable_get(:@game_adapter).class).to eq(GameAdapter)
    end
  end

  describe '.leave_the_game' do
    it 'leaves the game' do
      expect(described_class).to receive(:exit).with(true)
      described_class.leave_the_game
    end
  end

  describe '#choose_option' do
    it 'shows game rules and closes app when repeat is turned off' do
      console.instance_variable_set(:@repeat, false)
      allow(console).to receive(:gets).and_return('rules')
      expect(console.choose_option.class).to eq(NilClass)
    end

    it 'shows stats and closes app when repeat is turned of' do
      console.instance_variable_set(:@repeat, false)
      allow(console).to receive(:gets).and_return('stats')
      expect(console.choose_option.class).to eq(NilClass)
    end

    it 'registrates game' do
      allow(console).to receive(:gets).and_return('start')
      expect(console.instance_variable_get(:@registrator)).to receive(:registrate_game)
      console.choose_option
    end

    it 'prompts to enter correct command if wrong command entered' do
      console.instance_variable_set(:@repeat, false)
      allow(console).to receive(:gets).and_return('startttt', 'stats')
      expect(console.choose_option.class).to eq(NilClass)
    end
  end

  describe '#start' do
    before { game.instance_variable_set(:@attempts, 1) }

    it 'loses the game' do
      allow(game_adapter).to receive(:gets).and_return('1234')
      expect(game_adapter).to receive(:lose)
      console.start(game)
    end
  end
end
