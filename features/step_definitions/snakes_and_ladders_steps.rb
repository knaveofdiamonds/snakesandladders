Given /^a board with:$/ do |table|
  tunnels = table.hashes.inject({}) do |acc, row|
    acc[row["from"].to_i] = row["to"].to_i
    acc
  end
  @board = Board.new(tunnels)
end

When /^I start a game with (\d) players$/ do |players|
  @board.start(players.to_i)
end

When /^player (\d) rolls (\d)$/ do |player, roll|
  @board.current_player.should == player.to_i
  @board.roll(roll.to_i)
end

Then /^player (\d) is now on position (\d+)$/ do |player, position|
  @board.position_of(player.to_i).should == position.to_i
end

Given /^player (\d) is on position (\d+)$/ do |player, position|
  @board.start(2)
  @board.set_position_of(player.to_i, position.to_i)
end

Then /^it is now player (\d)'s go$/ do |player|
  @board.current_player.should == player.to_i
end

Then /^player (\d) has won the game$/ do |player|
  @board.winner.should == player.to_i
end