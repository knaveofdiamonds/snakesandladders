class Board
  def initialize(tunnels)
    @tunnels = tunnels
  end
  
  def resulting_square(square)
    bounce_back(@tunnels[square] || square, 100)
  end
  
  private
  def bounce_back(new_square, max)
    if new_square > max
      new_square = max - (new_square - max)
    end
    new_square
  end
end

class Game
  attr_reader :current_player
  def initialize(player_count, board)
    @players = Array.new(player_count, 0)
    @board = board
    @current_player = 1
  end
  
  def roll(squares)
    set_position_of(@current_player, @board.resulting_square(position_of(@current_player) + squares))
    @current_player = (@current_player % @players.size) + 1 unless squares == 6
  end
  
  def position_of(player)
    @players[player - 1]
  end
  
  def set_position_of(player, position)
    @players[player - 1] = position
  end
  
  def winner
    @players.index(100) + 1 if @players.index(100)
  end
end
