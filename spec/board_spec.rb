require File.dirname(__FILE__) + '/spec_helper'

describe Board do
  before(:each) do
    @board = Board.new({1 => 0, 2 => 3}, {})
  end
  
  context "in initial state" do
    it "starts with the correct number of players" do
      @board.player_count.should == 2
    end
    it "sets the current player to 1" do
      @board.current_player.should == 1
    end
  end
  
  context "during normal play" do
    it "moves the current player the correct number of spaces" do
      @board.roll(2)
      @board.position_of(1).should == 2
    end
    
    it "moves the player to the end point of a tunnel if they land on the start point" do
      @board = Board.new({1 => 0}, {2 => 5})
      @board.roll(2)
      @board.position_of(1).should == 5
    end
    
    context "with a roll of 1 - 5" do
      it "makes it the next player's go" do
        @board.roll(2)
        @board.current_player.should == 2
      end
      it "makes it the first player's go if the last player has gone" do
        @board.roll(2)
        @board.roll(2)
        @board.current_player.should == 1
      end
    end
    context "with a roll of 6" do
      it "gives the current player another go" do
        @board.roll(6)
        @board.current_player.should == 1
      end
    end
  end
  
  context "with tunnels" do
    it "returns the end point of the tunnel if there's a tunnel starting on the square" do
      @board = Board.new({1 => 0}, {2 => 5})
      @board.tunnel_at(2).should == 5
    end
  end
  
  context "nearing win position" do
    
    before(:each) do
      @board = Board.new({1 => 96}, {})
    end
    it "returns player as the winner if they reach square 100" do
      @board.roll(4)
      @board.winner.should == 1
    end
    
    it "bounces the player back if he goes past 100" do
      @board.roll(6)
      @board.position_of(1).should == 98
      @board.winner.should be_nil
    end
  end
  
  it "returns the position of any player" do
    @board.position_of(1).should == 0
    @board.position_of(2).should == 3
  end
end
