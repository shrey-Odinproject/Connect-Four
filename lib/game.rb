require './lib/display'
class Game
  include Display
  def initialize
    @board = Board.new
    @player_1 = nil
    @player_2 = nil
    @current_player = nil
  end

  def setup_player(num, symbol)
    puts display_ask_player_name(num)
    name = gets.chomp
    Player.new(name, symbol)
  end

  def give_valid_input(name, symbol)
    loop do
      input = ask_player_input(name, symbol)
      return input.to_i if valid?(input)

      puts display_incorrect_input
    end
  end

  def ask_player_input(name, symbol)
    puts display_ask_input(name, symbol)
    gets.chomp
  end

  def valid?(input)
    input !~ /\D/ && input.to_i >= 0 && input.to_i <= 6
  end
end
