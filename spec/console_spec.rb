# frozen_string_literal: true

RSpec.describe Console do
  include MenuOptions
  let(:console) { described_class.new }
  let(:game) { Codebreaker::Game.new(Codebreaker::Player.new('Dima'), :easy) }

  describe '.initialize' do
    it 'has options field' do
      expect(console.instance_variables.include?(:@options)).to be(true)
    end

    it 'options is a String' do
      expect(console.instance_variable_get(:@options).class).to eq(String)
    end
  end

  describe '#choose_option' do
    it 'leaves the game' do
      expect(console).to receive(:leave_the_game)
      console.choose_option { 'exit' }
    end

    it 'shows rules' do
      expect(console).to receive(:show_rules)
      console.choose_option { 'rules' }
    end

    it 'starts the game' do
      expect(console).to receive(:registrate_game)
      console.choose_option { 'start' }
    end

    it 'show stats' do
      allow(console).to receive(:show_stats)
      console.choose_option { 'stats' }
      expect(console).to have_received(:show_stats)
    end

    it 'raises wrong command' do
      console.choose_option { '1234' }
      expect(console).to receive(:wrong_command)
    end
  end
end
