# frozen_string_literal: true

RSpec.describe StatisticSorter do
  let(:stats_sorter) { described_class.new }

  describe '#show_stats' do
    it 'returns array if file exists' do
      expect(stats_sorter.show_stats.class).to eq(Array)
    end

    it 'returns string if file does not exist' do
      stub_const('StatisticSorter::GAME_RESULTS_FILE', 'res.yml')
      expect(stats_sorter.show_stats.class).to eq(String)
    end
  end
end
