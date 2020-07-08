# frozen_string_literal: true

# game ending
module GameEnding
  YES_ANSWER = 'y'
  NO_ANSWER = 'n'
  SAVE_RESULTS_MESSAGE = "Do you want to save results ? #{YES_ANSWER}/#{NO_ANSWER}"
  START_NEW_GAME_MESSAGE = "Do you want to start new game ? #{YES_ANSWER}/#{NO_ANSWER}"
  WRONG_FORMAT_MESSAGE = "Put only '#{YES_ANSWER}'(YES) or '#{NO_ANSWER}'(NO)"

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
    when YES_ANSWER then true
    when NO_ANSWER then false
    else wrong_format(message)
    end
  end

  def wrong_format(message)
    raise Codebreaker::WrongCommandError, WRONG_FORMAT_MESSAGE
  rescue Codebreaker::WrongCommandError => e
    alert_input_error(e) { continue?(message) }
  end
end
