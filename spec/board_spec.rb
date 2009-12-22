require File.dirname(__FILE__) + '/spec_helper'

describe Board do
  
  before(:each) do
    @board = Board.new({3 => 5})
    @board.start(2)
  end
  
  context "starting a game" do
    
    it "initializes with the correct number of players" do
      @board.player_count.should == 2
    end
    
    it "sets the current player to 1" do
      @board.current_player.should == 1
    end
    
    it "sets the position of each player to 0" do
      @board.position_of(1).should == 0
      @board.position_of(2).should == 0
    end
    
    it "has no winner" do
      @board.winner.should be_nil
    end
  end
  
  context "taking a turn" do
    it "moves the player by the specified amount" do
      @board.roll(2)
      @board.position_of(1).should == 2
    end
    
    context "player rolls 1-5" do
      it "makes it the next player's turn" do
        @board.roll(2)
        @board.current_player.should == 2
      end

      it "makes it the first player's turn if the last player has just rolled" do
        @board.roll(2)
        @board.roll(2)
        @board.current_player.should == 1
      end
      
    end
    
    context "player rolls a 6" do
      it "allows the player to roll again" do
        @board.roll(6)
        @board.current_player.should == 1
      end
    end
    
    it "moves the player to the end of a tunnel if the player ends up on a start point" do
      @board.roll(3)
      @board.position_of(1).should == 5
    end
  end
  
  context "setting position" do
    it "sets the position of the given player" do
      @board.set_position_of(1, 50)
      @board.position_of(1).should == 50
    end
  end
  
  context "winning the game" do
    it "has a winner if a player gets to 100" do
      @board.set_position_of(1, 99)
      @board.roll(1)
      @board.winner.should == 1
    end
    
    it "bounces the user back if they go over 100" do
      @board.set_position_of(1, 99)
      @board.roll(3)
      @board.position_of(1).should == 98
    end
  end
end
