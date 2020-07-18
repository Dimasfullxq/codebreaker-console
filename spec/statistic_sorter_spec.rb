# frozen_string_literal: true

RSpec.describe StatisticSorter do
  let(:stats_sorter) { described_class.new }

  before do
    player = Codebreaker::Player.new('Dima')
    file = File.open('res.yml', 'w')
    data = [{ player: player, difficulty: :easy, attempts_total: 15,
              attempts_used: 10, hints_total: 2, hints_used: 1 }]
    file.write(data.to_yaml)
    file.close
  end

  after { File.delete('res.yml') }

  describe '#show_stats' do
    it 'returns array if file exists' do
      stub_const('StatisticSorter::GAME_RESULTS_FILE', 'res.yml')
      expect(stats_sorter.show_stats.class).to eq(Array)
    end

    it 'returns string if file does not exist' do
      stub_const('StatisticSorter::GAME_RESULTS_FILE', 'res1.yml')
      expect(stats_sorter.show_stats.class).to eq(String)
    end
  end
end
