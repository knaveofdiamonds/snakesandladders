def board(size, tunnels)
  lambda {|i| tunnels[i] || i }
end

def move(board, players, player, roll)
  players[player] = board[ players[player] + roll ]
  [players, next_player(player, roll)]
end

def next_player(player, roll)
  roll == 6 ? player : player + 1
end
