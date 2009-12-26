def board_builder
  @board_builder ||= BoardBuilder.new
end

def board
  @board ||= board_builder.build
end

Given /^a board with:$/ do |table|
  table.hashes.each do |row|
    board_builder.add_tunnel(row["from"].to_i, row["to"].to_i)
  end
end

Given /^the game has (\d) players$/ do |players|
  players.to_i.times do |i|
    board_builder.add_player(i + 1)
  end
end

When /^player (\d) rolls (\d)$/ do |player, roll|
  board.current_player.should == player.to_i
  board.roll(roll.to_i)
end

Then /^player (\d) is now on position (\d+)$/ do |player, position|
  board.position_of(player.to_i).should == position.to_i
end

Given /^player (\d) is on position (\d+)$/ do |player, position|
  board_builder.add_player(player.to_i, position.to_i)
end

Then /^it is now player (\d)'s go$/ do |player|
  board.current_player.should == player.to_i
end

Then /^player (\d) has won the game$/ do |player|
  board.winner.should == player.to_i
end
