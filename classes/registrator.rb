# frozen_string_literal: true

# registrator entity
class Registrator
  include Input

  def registrate_game
    system('clear')
    create_game(create_player)
  end

  private

  def create_player
    name = field_set(NAME_MESSAGE)
    Codebreaker::Player.validate(name)
    Codebreaker::Player.new(name)
  rescue StandardError => e
    alert_input_error(e) { create_player }
  end

  def create_game(player)
    difficulty = field_set(DIFFICULTY_MESSAGE)
    Codebreaker::Game.validate(difficulty)
    Codebreaker::Game.new(player, difficulty)
  rescue StandardError => e
    alert_input_error(e) { create_game(player) }
  end
end
