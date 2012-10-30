Given /^a board with:$/ do |table|
  tunnels = table.hashes.inject({}) do |memo, row|
    memo[row["from"].to_i] = row["to"].to_i
    memo
  end
  @board = Board.new(tunnels)
end

Given /^I start a game with (\d+) players$/ do |player_count|
  @game = Game.new(player_count.to_i, @board)
end

Given /^player (\d+) rolls (\d+)$/ do |player, squares|
  @game.roll(squares.to_i)
end

Then /^player (\d+) is now on position (\d+)$/ do |player, position|
  @game.position_of(player.to_i).should == position.to_i
end

Given /^player (\d+) is on position (\d+)$/ do |player, position|
  @game.set_position_of(player.to_i, position.to_i)
end

Then /^it is now player (\d+)'s go$/ do |player| #'
  @game.current_player.should == player.to_i
end

Then /^player (\d+) has won the game$/ do |player|
  @game.winner.should == player.to_i
end