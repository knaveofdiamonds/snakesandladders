def board(size, tunnels)
  bounces = (1..6).inject({}) {|hsh, i| hsh[size + i] = size - i ; hsh }
  tunnels = tunnels.merge(bounces)

  lambda {|i| tunnels[i] || i }
end

def move(board, players, player, roll)
  players[player] = board[ players[player] + roll ]
  [players, next_player(player, roll)]
end

def next_player(player, roll)
  roll == 6 ? player : player + 1
end

def winner(size, positions)
  positions.index(size)
end
