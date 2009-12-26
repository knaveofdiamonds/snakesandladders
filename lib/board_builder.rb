class BoardBuilder
  
  def initialize
    @players = {}
    @tunnels = {}
  end
  
  def build
    Board.new(@players, @tunnels)
  end
  
  def add_player(player, position = 0)
    @players[player] = position
    self
  end
  
  def add_tunnel(from, to)
    @tunnels[from] = to
    self
  end
end