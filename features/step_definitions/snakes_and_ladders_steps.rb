Given /^a board with:$/ do |table|
  tunnels = table.rows.inject({}) {|board, row|
    board.merge(row[1].to_i => row[2].to_i)
  }
  @board = board(100, tunnels)
end

Given /^I start a game with (\d+) players$/ do |number_of_players|
  @players = [0] * number_of_players.to_i
end

Given /^player (\d+) rolls (\d+)$/ do |player, roll|
  @new_positions, @next_player = move(@board, 
                                      @players, 
                                      player.to_i - 1, 
                                      roll.to_i)
end

Then /^player (\d+) is now on position (\d+)$/ do |player, position|
  @new_positions[player.to_i - 1].should == position.to_i
end

Given /^player (\d+) is on position (\d+)$/ do |player, position|
  @players[player.to_i - 1] = position.to_i
end

Then /^it is now player (\d+)\'s go$/ do |player|
  @next_player.should == player.to_i - 1
end

Then /^player (\d+) has won the game$/ do |player|
  winner(100, @new_positions).should == player.to_i - 1
end
