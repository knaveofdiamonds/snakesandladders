Given /^a board with:$/ do |table|
  tunnels = table.hashes.inject({}) do |acc, hash|
    acc[hash["from"].to_i] = hash["to"].to_i
    acc
  end
  @board = Board.new(tunnels)
end

When /^I start a game with (\d) players$/ do |num|
  @board.start(num.to_i)
end

When /^(player \d) (rolls \d)$/ do |player, roll|
  @board.current_player.should == player
  @board.roll(roll)
end

Then /^(player \d) is now on (position \d+)$/ do |player, position|
  @board.position_of(player).should == position
end

Given /^(player \d) is on (position \d+)$/ do |player, position|
  @board.set_position_of(player, position)
end

Then /^it is now (player \d)'s go$/ do |player|
  @board.current_player.should == player
end

Then /^(player \d) has won the game$/ do |player|
  @board.winner.should == player
end

Transform /^(?:player|position|rolls) (\d+)$/ do |num|
  num.to_i
end
