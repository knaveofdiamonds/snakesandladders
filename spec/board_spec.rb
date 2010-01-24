require File.dirname(__FILE__) + '/spec_helper'

describe Board do
  
  before(:each) do
    @board = Board.new(2, {})
  end
  
  context "in initial state" do
    it "stores the current player" do
      @board.current_player.should == 1
    end

    it "gets the current position of a player" do
      @board.position_of(1) == 0
    end
    
    it "has no winner" do
      @board.winner.should be_nil
    end
  end
  
  it "sets the position of a player" do
    @board.set_position_of(2, 20)
    @board.position_of(2).should == 20
  end
  
  context "during normal play" do
    it "moves the player forward by the amount rolled" do
      @board.roll(3)
      @board.position_of(1).should == 3
    end
    
    it "makes it the next player's turn" do
      @board.roll(2)
      @board.current_player.should == 2
    end
    
    it "makes it the first person's turn when the last player's go ends" do
      @board.roll(2)
      @board.roll(2)
      @board.current_player.should == 1
    end
    
    it "sets the winner if the user reaches square 100" do
      @board.set_position_of(1, 97)
      @board.roll(3)
      @board.winner.should == 1
    end
    
    it "bounces a player back if they go beyond 100" do
      @board.set_position_of(1, 97)
      @board.roll(4)
      @board.position_of(1).should == 99
    end
    
    context "when rolling a 6" do
      it "makes it the same player's go" do
        @board.roll(6)
        @board.current_player.should == 1
      end
    end
  end
  
  context "with tunnels" do
    it "moves the player to the end of a tunnel" do
      @board = Board.new(2, {1 => 5})
      @board.roll(1)
      @board.position_of(1).should == 5
    end
  end

end
