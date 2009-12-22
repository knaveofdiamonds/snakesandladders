class Board
  attr_reader :player_count, :current_player, :winner
  
  BOARD_SIZE = 100
  
  def initialize(tunnels = {})
    @tunnels = tunnels
  end
  
  def start(player_count)
    @player_count = player_count
    @current_player = 1
    @positions = Array.new(@player_count, 0)
  end
  
  def roll(amount)
    set_position_of(@current_player, position_of(@current_player) + amount)
    @winner = @current_player if position_of(@current_player) == BOARD_SIZE
    @current_player = (@current_player % @player_count) + 1 unless amount == 6
  end
  
  def position_of(player)
    @positions[player - 1]
  end
  
  def set_position_of(player, value)
    @positions[player - 1] = limit_value_to_board_size(value)
    adjust_for_tunnel
  end
  
  private 
  def limit_value_to_board_size(value)
    value > BOARD_SIZE ? BOARD_SIZE - (value - BOARD_SIZE) : value
  end
  
  def adjust_for_tunnel
    if (new_position = @tunnels[position_of(@current_player)])
      set_position_of(@current_player, new_position)
    end
  end
end