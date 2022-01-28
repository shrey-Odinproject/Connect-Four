module Display
  def display_intro
    'starting new game of connect four ...'
  end

  def display_ask_player_name(num)
    "player #{num} enter your name"
  end

  def display_incorrect_input
    'Erronous input ! try again'
  end

  def display_ask_input(name, symbol)
    "#{name} which column to place #{symbol} in ?"
  end

  def display_win_message(name)
    " Game Over ! #{name} has won "
  end

  def display_draw_message
    'Game over its a DRAW'
  end
end
