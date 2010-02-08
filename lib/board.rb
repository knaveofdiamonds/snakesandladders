class Board
  WIN_SQUARE = 100
  attr_reader :current_player, :winner
  def initialize(tunnels)
    @tunnels = tunnels
  end
  
  def start(players)
    @players = Array.new(players, 0)
    @current_player = 1
  end
  
  def roll(roll)
    set_position_of(current_player, position_of(current_player) + roll)
    @current_player = (current_player % @players.size) + 1 unless roll == 6
  end
  
  def position_of(player)
    @players[player - 1]
  end
  
  def set_position_of(player, position)
    new_position = final_square_for(position)
    @players[player - 1] = new_position
    @winner = player if new_position == WIN_SQUARE
  end
  
  private
  def final_square_for(position)
    new_position = @tunnels[position] || position
    new_position = (WIN_SQUARE * 2) - new_position if new_position > WIN_SQUARE
    new_position
  end
end