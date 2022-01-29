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

  def keep_playing
    @current_player = player1
    until board.full? do
      make_move(current_player)
      break if board.win?

      @current_player = switch_players
    end
  end

  def final_message
    if board.win?
      puts display_win_message(current_player.name)
    else
      puts display_draw_message
    end
  end

  def game_setup
    puts display_intro
    @player1 = setup_player(1, "\u26bd")
    @player2 = setup_player(2, "\u26be")
  end

  def main
    game_setup
    board.show
    keep_playing
    final_message
  end
end
