# frozen_string_literal: true

# game ending
module GameEnding
  SAVE_RESULTS_MESSAGE = 'Do you want to save results ? y/n'
  START_NEW_GAME_MESSAGE = 'Do you want to start new game ? y/n'
  WRONG_FORMAT_MESSAGE = "Put only 'y'(YES) or 'n'(NO)"

  include Input

  private

  def continue?(message)
    puts message + "\nAnswer: "
    answer = gets.chomp
    check_the_final_answers(answer, message)
  end

  def check_the_final_answers(answer, message)
    case answer
    when EXIT_COMMAND then leave_the_game
    when 'y' then true
    when 'n' then false
    else wrong_format(message)
    end
  end

  def wrong_format(message)
    raise Codebreaker::WrongCommandError, WRONG_FORMAT_MESSAGE
  rescue Codebreaker::WrongCommandError => e
    alert_input_error(e) { continue?(message) }
  end
end
