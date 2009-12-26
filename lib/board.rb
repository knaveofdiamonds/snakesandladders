class Board
  
  attr_reader :current_player, :winner
  
  BOARD_SIZE = 100
  
  def initialize(players, tunnels)
    @current_player = 1
    @positions = players
    @tunnels = tunnels
  end
  
  def player_count
    @positions.size
  end
  
  def roll(squares)
    increment_position_of current_player, squares
    @winner = current_player if position_of(current_player) == BOARD_SIZE
    @current_player = (current_player % player_count) + 1 unless squares == 6
  end
  
  def position_of(player)
    @positions[player]
  end
  
  def tunnel_at(position)
    @tunnels[position]
  end
  
  private
  def set_position_of(player, position)
    if position > BOARD_SIZE
      position = BOARD_SIZE - (position - BOARD_SIZE)
    end
    position = tunnel_at(position) || position
    @positions[player] = position
  end
  
  def increment_position_of(player, squares)
    set_position_of player, position_of(player) + squares
  end
end