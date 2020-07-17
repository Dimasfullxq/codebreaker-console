# frozen_string_literal: true

require_relative 'config/uploader'

puts 'Welcome to the Codebreaker Game!'
game_adapter = GameAdapter.new
console = Console.new(game_adapter)
game = console.choose_option
system('clear')
console.start(game)
