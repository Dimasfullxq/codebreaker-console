# frozen_string_literal: true

RSpec.describe Console do
  let(:console) { described_class.new }
  let(:game) { Codebreaker::Game.new(Codebreaker::Player.new('Dima'), 'easy') }

  before do
    allow($stdout).to receive(:write)
  end

  describe '.initialize' do
    it 'has options field' do
      expect(console.instance_variables.include?(:@options)).to be(true)
    end

    it 'options is a String' do
      expect(console.options.class).to eq(String)
    end
  end

  describe '#choose_option' do
    it 'creates a game object' do
      allow(console).to receive(:gets).and_return('start', 'Dima', 'easy')
      allow(console).to receive(:create_player).and_return(Codebreaker::Player.new('Dima'))
      expect(console.choose_option.class).to eq(Codebreaker::Game)
    end

    it 'rescues ShortNameError' do
      allow(console).to receive(:gets).and_return('start', 'Di', 'easy')
      expect(console).to receive(:alert_input_error).with(Codebreaker::ShortNameError)
      console.choose_option
    end

    it 'rescues LongNameError' do
      allow(console).to receive(:gets).and_return('start', 'VeryBigNameforThisGame', 'easy')
      expect(console).to receive(:alert_input_error).with(Codebreaker::LongNameError)
      console.choose_option
    end

    it 'rescues WrongCommandError to choose correct difficulty' do
      allow(console).to receive(:gets).and_return('start', 'Dimon', 'easyyyyyyyy')
      expect(console).to receive(:alert_input_error).with(Codebreaker::WrongCommandError)
      console.choose_option
    end

    it 'leaves the game' do
      allow(console).to receive(:gets).and_return('exit')
      expect(console).to receive(:exit).with(true)
      console.choose_option
    end

    it 'shows game rules' do
      allow(console).to receive(:gets).and_return('rules')
      expect(console).to receive(:show_rules)
      console.choose_option
    end

    it 'leaves the game after rules' do
      allow(console).to receive(:gets).and_return('rules', 'exit')
      expect(console).to receive(:exit).with(true)
      console.choose_option
    end

    it 'shows game stats' do
      allow(console).to receive(:gets).and_return('stats')
      expect(console).to receive(:show_stats)
      console.choose_option
    end

    it 'leaves the game after' do
      allow(console).to receive(:gets).and_return('stats', 'exit')
      expect(console).to receive(:exit).with(true)
      console.choose_option
    end

    it 'prompts to enter correct command' do
      allow(console).to receive(:gets).and_return('hello')
      expect(console).to receive(:wrong_command)
      console.choose_option
    end

    it 'leaves the game after wrong command' do
      allow(console).to receive(:gets).and_return('hello', 'exit')
      expect(console).to receive(:exit).with(true)
      console.choose_option
    end
  end
end
