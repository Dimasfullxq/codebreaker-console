# frozen_string_literal: true

# input module
module Input
  START_COMMAND = 'start'
  RULES_COMMAND = 'rules'
  STATS_COMMAND = 'stats'
  EXIT_COMMAND = 'exit'
  HINT_COMMAND = 'hint'
  NAME_MESSAGE = "Enter your name(from #{Codebreaker::Validator::NAME_MIN_SIZE} to" \
                 " #{Codebreaker::Validator::NAME_MAX_SIZE} symbols) or '#{EXIT_COMMAND}' to leave the game: "
  DIFFICULTY_MESSAGE = "Choose difficulty: #{Codebreaker::Validator::DIFFICULTY_LIST} " \
                       "or enter '#{EXIT_COMMAND}' to leave the game: "
  GUESS_MESSAGE = "Enter '#{EXIT_COMMAND}' to leave the game, '#{HINT_COMMAND}' to take a hint.\n" \
                  'Enter your guess of code: '

  private

  def create_player
    name = field_set(NAME_MESSAGE)
    Codebreaker::Player.new(name) if Codebreaker::Player.valid?(name)
  rescue StandardError => e
    alert_input_error(e) { create_player }
  end

  def create_game(player)
    difficulty = field_set(DIFFICULTY_MESSAGE)
    Codebreaker::Game.new(player, difficulty) if Codebreaker::Game.valid?(difficulty)
  rescue StandardError => e
    alert_input_error(e) { create_game(player) }
  end

  def enter_guess(game)
    guess = field_set("Attempts: #{game.attempts}\nHints: #{game.hints}\n" + GUESS_MESSAGE)
    guess if guess == HINT_COMMAND || Codebreaker::Game.guess_valid?(guess)
  rescue StandardError => e
    alert_input_error(e) { enter_guess(game) }
  end

  def field_set(message)
    print message
    field = gets.chomp
    leave_the_game if field == EXIT_COMMAND
    field
  end

  def alert_input_error(error)
    puts error.message
    yield if block_given?
  end
end
