# frozen_string_literal: true

# console entity
class Console
  include InputService

  def initialize
    @game_adapter = GameAdapter.new(self)
    @registrator = Registrator.new
    @stats_sorter = StatisticSorter.new
    @repeat = true
  end

  def choose_option
    select_option(field_set(OPTIONS))
  end

  def start(game)
    puts "#{YOUR_DIFFICULTY} #{game.difficulty}"
    while game.attempts.positive?
      guess = @game_adapter.enter_guess(game)
      check = @game_adapter.check_set(game, guess)
      check.instance_of?(String) ? puts(check) : puts("#{YOUR_HINT} #{check}")
      @game_adapter.win(game, guess)
    end
    @game_adapter.lose(game)
  end

  def self.leave_the_game
    system('clear')
    puts GOODBYE_MESSAGE
    exit(true)
  end

  private

  def select_option(answer)
    case answer
    when START_COMMAND then @registrator.registrate_game
    when RULES_COMMAND then show_rules
    when STATS_COMMAND then show_stats
    else wrong_command
    end
  end

  def show_rules
    system('clear')
    puts '***' * 50
    puts File.open('rules.txt', 'r').read
    puts '***' * 50
    choose_option if @repeat
  end

  def show_stats
    system('clear')
    stats = @stats_sorter.show_stats
    if stats.instance_of?(String) then puts stats
    else stats.size.times { |i| puts "Rating: #{i + 1}\n#{stats[i]}\n#{'***' * 50}" }
    end
    choose_option if @repeat
  end

  def wrong_command
    raise Codebreaker::WrongCommandError
  rescue Codebreaker::WrongCommandError => e
    alert_input_error(e) { choose_option }
  end
end
