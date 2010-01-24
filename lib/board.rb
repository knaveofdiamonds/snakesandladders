class Board
  
  BOARD_SIZE = 100
  
  attr_accessor :current_player, :winner
  def initialize(players, tunnels)
    @players = players
    @tunnels = tunnels
    @positions = Array.new(players, 0)
    @current_player = 1
  end
  
  def roll(num)
    advance_position_of(@current_player, num)
    @current_player = (@current_player % @players) + 1 unless num == 6
  end
  
  def position_of(player)
    @positions[player - 1]
  end
  
  def set_position_of(player, position)
    @positions[player - 1] = position
    adjust_for_tunnels!(player)
    bounce_player_back!(player)
    @winner = player if position_of(player) == BOARD_SIZE
  end
  
  private
  
  def adjust_for_tunnels!(player)
    if position = @tunnels[position_of(player)]
      set_position_of(player, position)
    end
  end
  
  def bounce_player_back!(player)
    if (position = position_of(player)) > BOARD_SIZE
      set_position_of(player, BOARD_SIZE - (position - BOARD_SIZE))
    end
  end
  
  def advance_position_of(player, num)
    set_position_of(player, position_of(player) + num)
  end
end