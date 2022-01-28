require './lib/display'
class Game
  include Display
  def initialize
    @board=Board.new
    @player_1=nil
    @player_2=nil
    @current_player=nil
  end

  def setup_player(num)
    puts display_ask_player_name(num)
    name=gets.chomp
    symbol="\u26bd"
    Player.new(name,symbol)
  end
end