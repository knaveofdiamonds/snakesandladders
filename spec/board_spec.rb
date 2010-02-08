require File.dirname(__FILE__) + '/spec_helper'

describe Board do
  
  def board_with_2_players
    board = Board.new({5 => 10})
    board.start(2)
    board
  end
  
  context "when starting with 2 players" do
    
    before(:each) do
      @board = board_with_2_players
    end
    
    it "has player 1 at position 0" do
      @board.position_of(1).should == 0
    end
    
    it "has player 2 at position 0" do
      @board.position_of(2).should == 0
    end
    
    it "sets the current player to 1" do
      @board.current_player.should == 1
    end
  end
  
  context "when moving" do
    before(:each) do
      @board = board_with_2_players
    end
    
    it "moves the player by the given amount" do
      @board.roll(1)
      @board.position_of(1).should == 1
    end
    
    context "1 to 5" do
      it "increments the current player" do
        @board.roll(1)
        @board.current_player.should == 2
      end
      
      it "increments the current player back to 1 if the last player just moved" do
        @board.roll(1)
        @board.roll(1)
        @board.current_player.should == 1
      end
    end
    
    context "a 6" do
      it "gives the current player another go" do
        @board.roll(6)
        @board.current_player.should == 1
      end
    end
    
    context "around tunnels" do
      it "moves a user from the start point to the end point" do
        @board.roll(5)
        @board.position_of(1).should == 10
      end
    end
    
    context "into winning position" do
      it "makes the current player the winner" do
        @board.set_position_of(1, 99)
        @board.roll(1)
        @board.winner.should == 1
      end
    end
    
    context "over winning margin" do
      it "bounces the player back the excess number of squares" do
        @board.set_position_of(1, 99)
        @board.roll(5)
        @board.position_of(1).should == 96
      end
    end
  end
  
  it "sets the position of a player" do
    board = board_with_2_players
    board.set_position_of(2, 40)
    board.position_of(2).should == 40
  end
end
