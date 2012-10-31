Given /^a board with:$/ do |table|
  tunnels = table.rows.inject({}) {|board, row|
    board.merge(row[1].to_i => row[2].to_i)
  }
  @board = board(100, tunnels)
end

Given /^I start a game with (\d+) players$/ do |number_of_players|
  @players = [0] * number_of_players.to_i
  @next_player = 0
end

Given /^player (\d+) rolls (\d+)$/ do |p, roll|
  @new_positions, @next_player = move(@board, 
                                      @players, 
                                      player(p), 
                                      roll.to_i)
end

When /^a (\d+) is rolled$/ do |roll|
  step "player #{@next_player + 1} rolls #{roll}"
end


Then /^player (\d+) is now on position (\d+)$/ do |p, position|
  @new_positions[player(p)].should == position.to_i
end

Given /^player (\d+) is on position (\d+)$/ do |p, position|
  @players[player(p)] = position.to_i
end

Then /^it is now player (\d+)\'s go$/ do |p|
  @next_player.should == player(p)
end

Then /^player (\d+) has won the game$/ do |p|
  winner(100, @new_positions).should == player(p)
end
