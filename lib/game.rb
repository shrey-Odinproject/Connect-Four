require './lib/display'
# handles gameplay
class Game
  include Display
  attr_reader :board, :current_player, :player1, :player2

  def initialize
    @board = Board.new
    @player1 = nil
    @player2 = nil
    @current_player = nil
  end

  def setup_player(num, symbol)
    puts display_ask_player_name(num)
    name = gets.chomp
    Player.new(name, symbol)
  end

  def get_valid_input(name, symbol)
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

  def make_move(player)
    name = player.name
    symbol = player.symbol
    col = get_valid_input(name, symbol)
    board.edit_grid(col, symbol)
    board.show
  end

  def switch_players
    if current_player == player1
      player2
    else
      player1
    end
  end
end
