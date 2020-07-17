# frozen_string_literal: true

# game config
module GameConfiguration
  WIN_MESSAGE = "Congratulations! You won! \nSecret code: "
  LOSE_MESSAGE = "You have no attempts left! You lost :(\nSecret code: "
  POSITIVE = '+'
  NEGATIVE = '-'
  NONE = ' '

  include GameEnding
  include MenuOptions
  include Input

  private

  def registrate_game
    system('clear')
    create_game(create_player)
  end

  def win(game, result)
    return unless result.to_i == game.secret_code

    puts WIN_MESSAGE + game.secret_code.to_s
    stats = game.create_stats
    game.save_results(GAME_RESULTS_FILE, stats) if continue?(SAVE_RESULTS_MESSAGE)
    finish(START_NEW_GAME_MESSAGE, game)
  end

  def lose(game)
    puts LOSE_MESSAGE + game.secret_code.to_s
    finish(START_NEW_GAME_MESSAGE, game)
  end

  def check_set(game, guess)
    guess == HINT_COMMAND ? take_hint(game) : convert_check(game.check_the_guess(guess))
  end

  def convert_check(check)
    POSITIVE * check[:positive] + NEGATIVE * check[:negative] + NONE * check[:none]
  end

  def take_hint(game)
    game.take_hint
  rescue Codebreaker::HintsError => e
    e.message
  end

  def finish(message, game)
    continue?(message) ? new_game(game) : leave_the_game
  end

  def new_game(game)
    system('clear')
    game = Codebreaker::Game.new(game.player, game.difficulty)
    start(game)
  end
end
