# frozen_string_literal: true

# game ending entity
class Finisher
  include InputService

  def agree?(message)
    check_the_final_answers(field_set(message), message)
  end

  private

  def check_the_final_answers(answer, message)
    case answer
    when YES_ANSWER then true
    when NO_ANSWER then false
    else wrong_format(message)
    end
  end

  def wrong_format(message)
    raise Codebreaker::WrongCommandError, WRONG_FORMAT_MESSAGE
  rescue Codebreaker::WrongCommandError => e
    alert_input_error(e) { agree?(message) }
  end
end
