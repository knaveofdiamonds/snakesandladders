Given /^a board with:$/ do |table|
  @tunnels = table.hashes.inject({}) do |tunnels, row|
    tunnels[row["from"].to_i] = row["to"].to_i
    tunnels
  end
end

Given /^I start a game with (\d) players$/ do |player_count|
  @board = Board.new(player_count.to_i, @tunnels)
end

When /^player (\d) rolls (\d)$/ do |player, roll|
  @board.current_player.should == player.to_i
  @board.roll(roll.to_i)
end

Then /^player (\d) is now on position (\d+)$/ do |player, position|
  @board.position_of(player.to_i).should == position.to_i
end

Given /^player (\d) is on position (\d+)$/ do |player, position|
  @board.set_position_of(player.to_i, position.to_i)
end

Then /^it is now player (\d)'s go$/ do |player|
  @board.current_player.should == player.to_i
end

Then /^player (\d) has won the game$/ do |player|
  @board.winner.should == player.to_i
end
