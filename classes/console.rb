# frozen_string_literal: true

# console entity
class Console
  include MenuOptions
  include GameConfiguration
  include Input

  attr_reader :options

  def initialize
    @options = "Please choose and enter an option:
    '#{START_COMMAND}' - to start the game,
    '#{RULES_COMMAND}' -  to see the rules of the game
    '#{STATS_COMMAND}' - to see stats
    '#{EXIT_COMMAND}' - to leave the game\nYour answer:"
  end

  def choose_option
    print @options
    select_option(yield)
  end

  def start(game)
    puts "Difficulty: #{game.difficulty}"
    while game.attempts.positive?
      guess = enter_guess(game)
      check = check_set(game, guess)
      check.is_a?(String) ? puts(check) : puts("Your hint: #{check}")
      win(game, guess)
    end
    lose(game)
  end

  private

  def select_option(answer)
    case answer
    when START_COMMAND then registrate_game
    when RULES_COMMAND then show_rules
    when STATS_COMMAND then show_stats
    when EXIT_COMMAND then leave_the_game
    else wrong_command
    end
  end
end
