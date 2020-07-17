# frozen_string_literal: true

# input module
module Input
  START_COMMAND = 'start'
  RULES_COMMAND = 'rules'
  STATS_COMMAND = 'stats'
  EXIT_COMMAND = 'exit'
  HINT_COMMAND = 'hint'
  GOODBYE_MESSAGE = 'Come back soon. Bye bye'
  OPTIONS = "Please choose and enter an option:
  '#{START_COMMAND}' - to start the game,
  '#{RULES_COMMAND}' -  to see the rules of the game
  '#{STATS_COMMAND}' - to see stats
  '#{EXIT_COMMAND}' - to leave the game\nYour answer: "
  NAME_MESSAGE = "Enter your name(from #{Codebreaker::Validator::NAME_MIN_SIZE} to" \
                 " #{Codebreaker::Validator::NAME_MAX_SIZE} symbols) or '#{EXIT_COMMAND}' to leave the game: "
  DIFFICULTY_MESSAGE = "Choose difficulty: #{Codebreaker::Game::DIFFICULTIES.keys.map(&:to_s).join(', ')} " \
                       "or enter '#{EXIT_COMMAND}' to leave the game: "
  GUESS_MESSAGE = "Enter '#{EXIT_COMMAND}' to leave the game, '#{HINT_COMMAND}' to take a hint.\n" \
                  'Enter your guess of code: '
  WIN_MESSAGE = "Congratulations! You won! \nSecret code: "
  LOSE_MESSAGE = "You have no attempts left! You lost :(\nSecret code: "
  YES_ANSWER = 'y'
  NO_ANSWER = 'n'
  SAVE_RESULTS_MESSAGE = "Do you want to save results ? #{YES_ANSWER}/#{NO_ANSWER}"
  START_NEW_GAME_MESSAGE = "Do you want to start new game ? #{YES_ANSWER}/#{NO_ANSWER}"
  WRONG_FORMAT_MESSAGE = "Put only '#{YES_ANSWER}'(YES) or '#{NO_ANSWER}'(NO)"

  private

  def field_set(message)
    print message
    field = gets.chomp
    Console.leave_the_game if field == EXIT_COMMAND
    field
  end

  def alert_input_error(error)
    puts error.message
    yield if block_given?
  end
end
