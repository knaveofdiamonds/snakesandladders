class Board
  def initialize(tunnels)
    @tunnels = tunnels
  end
  
  def resulting_square(square)
    bounce_back(@tunnels[square] || square, 100)
  end
  
  def bounce_back(square, max)
    if square > max
      square = max - (square - max)
    end
    square
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
    resulting_square = @board.resulting_square(position_of(@current_player) + squares)
    set_position(@current_player, resulting_square)
    @current_player = (@current_player % @players.size) + 1 unless squares == 6
  end
  
  def position_of(player)
    @players[player - 1]
  end
  
  def set_position(player, position)
    @players[player - 1] = position
  end
  
  def winner
    @players.index(100) + 1 if @players.index(100)
  end
end
