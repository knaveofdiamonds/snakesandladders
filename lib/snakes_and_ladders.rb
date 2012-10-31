def board(size, tunnels)
  lambda {|i| tunnels[i] || i }
end

def move(board, players, player, roll)
  players[player] = board[ players[player] + roll ]
  [players, player + 1]
end
