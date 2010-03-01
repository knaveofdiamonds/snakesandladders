Given /^a board with:$/ do |table|
  tunnels = table.hashes.inject({}) do |acc, tunnel|
    acc[tunnel["from"].to_i] = tunnel["to"].to_i
    acc
  end
  @board = Board.new(tunnels)
end

Given /^I start a game with (\d) players$/ do |player_count|
  @game = Game.new(@board, player_count.to_i)
end

When /^player \d rolls (\d)$/ do |squares|
  @game.roll(squares.to_i)
end

Then /^player (\d) is now on position (\d+)$/ do |player, position|
  @game.position_of(player.to_i).should == position.to_i
end

Given /^player (\d) is on position (\d+)$/ do |player, position|
  @game.set_position_of(player.to_i, position.to_i)
end

Then /^it is now player (\d)'s go$/ do |player|
  @game.current_player.should == player.to_i
end

Then /^player (\d) has won the game$/ do |player|
  @game.winner.should == player.to_i
end
