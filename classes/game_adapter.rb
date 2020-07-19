# frozen_string_literal: true

# game adapter entity
class GameAdapter
  EXACT_MARKER = '+'
  WRONG_POSITION_MARKER = '-'
  EMPTY_MARKER = ' '

  include InputService

  def initialize(console)
    @console = console
    @finisher = Finisher.new
  end

  def enter_guess(game)
    guess = field_set("Attempts: #{game.attempts}\nHints: #{game.hints}\n" + GUESS_MESSAGE)
    return guess if guess == HINT_COMMAND

    Codebreaker::Game.validate_input(guess)
    guess
  rescue StandardError => e
    alert_input_error(e) { enter_guess(game) }
  end

  def win(game, result)
    return unless result.to_i == game.secret_code

    puts WIN_MESSAGE + game.secret_code.to_s
    stat_service = Codebreaker::StatisticService.new(Console::GAME_RESULTS_FILE)
    stat_service.save_results(game) if @finisher.agree?(SAVE_RESULTS_MESSAGE)
    finish(START_NEW_GAME_MESSAGE, game)
  end

  def lose(game)
    puts LOSE_MESSAGE + game.secret_code.to_s
    finish(START_NEW_GAME_MESSAGE, game)
  end

  def check_set(game, guess)
    guess == HINT_COMMAND ? take_hint(game) : convert_check(game.check_the_guess(guess))
  end

  private

  def convert_check(check)
    EXACT_MARKER * check[:exact_hit] + WRONG_POSITION_MARKER * check[:wrong_position_hit] +
      EMPTY_MARKER * check[:empty_hit]
  end

  def take_hint(game)
    game.take_hint
  rescue Codebreaker::HintsError => e
    e.message
  end

  def finish(message, game)
    @finisher.agree?(message) ? new_game(game) : Console.leave_the_game
  end

  def new_game(game)
    system('clear')
    game = Codebreaker::Game.new(game.player, game.difficulty)
    @console.start(game)
  end
end
