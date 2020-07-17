# frozen_string_literal: true

# game ending entity
class Finisher
  include Input

  def continue?(message)
    puts message + "\nAnswer: "
    answer = gets.chomp
    check_the_final_answers(answer, message)
  end

  private

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
