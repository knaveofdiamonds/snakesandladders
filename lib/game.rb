class Game
  attr_accessor :current_player, :winner
  def initialize(board, player_count)
    @board = board
    @player_count = player_count
    @player_positions = Array.new(@player_count, 0)
    @current_player = 1
  end
  
  def roll(squares)
    new_position = @board.position_from(position_of(current_player) + squares)
    set_position_of current_player, new_position
    @winner = @current_player if new_position == 100
    @current_player = (@current_player % @player_count) + 1 unless squares == 6
  end
  
  def set_position_of(player, position)
    @player_positions[player - 1] = position
  end
  
  def position_of(player)
    @player_positions[player - 1]
  end
end