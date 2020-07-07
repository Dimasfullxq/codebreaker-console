# frozen_string_literal: true

# menu functions
module MenuOptions
  include Statistics
  include Input

  private

  def leave_the_game
    system('clear')
    puts 'Come back soon. Bye bye'
    exit(true)
  end

  def show_rules
    system('clear')
    puts '***' * 50
    puts File.open('rules.txt', 'r').read
    puts '***' * 50
    choose_option { gets.chomp }
  end

  def show_stats
    system('clear')
    stats = create_table(sorted_stats)
    stats.size.times { |i| puts "Rating: #{i + 1}\n#{stats[i]}\n#{'***' * 50}" }
    choose_option { gets.chomp }
  end

  def wrong_command
    raise Codebreaker::WrongCommandError
  rescue Codebreaker::WrongCommandError => e
    alert_input_error(e) { choose_option { gets.chomp } }
  end
end
