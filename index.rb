# frozen_string_literal: true

require_relative 'config/uploader'

puts 'Welcome to the Codebreaker Game!'
console = Console.new
game = console.choose_option { gets.chomp }
system('clear')
console.start(game)
