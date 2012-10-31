def board(size, tunnels)
  Hash[(1..size).map{|i| [i, i] }].
    merge(Hash[(1..6).map{|i| [size + i, size - i] }]).
    merge(tunnels)
end

def move(board, players, player, roll)
  players[player] = board[ players[player] + roll ]
  [players, next_player(players.size, player, roll)]
end

def next_player(number_of_players, player, roll)
  roll == 6 ? player : ((player + 1) % number_of_players)
end

def winner(size, positions)
  positions.index(size)
end
