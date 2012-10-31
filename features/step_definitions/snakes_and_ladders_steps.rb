Given /^a board with:$/ do |table|
  @board = table.rows.inject({}) {|board, row|
    board.merge(row[1].to_i => row[2].to_i)
  }
end

Given /^I start a game with (\d+) players$/ do |number_of_players|
  @players = [0] * number_of_players.to_i
end

Given /^player (\d+) rolls (\d+)$/ do |player, roll|
  @result = move(@players, player.to_i - 1, roll.to_i)
end

Then /^player (\d+) is now on position (\d+)$/ do |player, position|
  @result[player.to_i - 1].should == position.to_i
end
