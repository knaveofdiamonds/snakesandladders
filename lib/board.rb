class Board
  def initialize(tunnels)
    @tunnels = tunnels
  end
  
  def position_from(square)
    bounce_back(@tunnels[square] || square, 100)
  end
  
  private
  def bounce_back(square, max)
    return square unless square > max
    max - (square - max)
  end
end