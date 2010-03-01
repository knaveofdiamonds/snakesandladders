require File.dirname(__FILE__) + '/spec_helper'

describe Game do
  
  before(:each) do
    @board = mock(Board, :position_from => 3)
    @game = Game.new(@board, 2)
  end
  
  context "in initial state" do
    it "has all players on position 0" do
      @game.position_of(1).should == 0
      @game.position_of(2).should == 0
    end
    
    it "has player 1 as the current player" do
      @game.current_player.should == 1
    end
  end
  
  context "getting and setting positions of players" do
    it "returns the set position of a player" do
      @game.set_position_of(2, 3)
      @game.position_of(2).should == 3
    end
  end
  
  context "rolling" do
    it "moves the player to the square according to the rules of the board" do
      @board.should_receive(:position_from).with(2).and_return(3)
      @game.roll(2)
      @game.position_of(1).should == 3
    end
    
    it "increments the current player" do
      @game.roll(2)
      @game.current_player.should == 2
    end
    
    it "makes the first player the current player after the last player rolls" do
      @game.roll(2)
      @game.roll(2)
      @game.current_player.should == 1
    end
    
    context "a 6" do
      it "gives the current player another roll" do
        @game.roll(6)
        @game.current_player.should == 1
      end
    end
    
    context "onto the win square" do
      it "makes the current player the winner" do
        @board.stub!(:position_from => 100)
        @game.roll(1)
        @game.winner.should == 1
      end
    end
  end
end
