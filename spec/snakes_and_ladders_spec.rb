require 'spec_helper'

describe Game do
  subject { Game.new(3, board) }
  let(:board) { stub(:resulting_square => 3) }
  
  context "in its initial state" do
    it "has all players in position 0" do
      subject.position_of(1).should == 0
      subject.position_of(2).should == 0
      subject.position_of(3).should == 0
    end
  end
  
  describe "roll" do
    it "moves the player forward by the number of squares, according to the rules of the board" do
      board.should_receive(:resulting_square).with(3).and_return(7)
      subject.roll(3)
      subject.position_of(1).should == 7
    end
    
    it "increments the current player" do
      subject.roll(3)
      subject.current_player.should == 2
      subject.roll(3)
      subject.current_player.should == 3
      subject.roll(3)
      subject.current_player.should == 1
    end
    
    it "doesn't increment the current player when the roll is a 6" do
      subject.roll(6)
      subject.current_player.should == 1
    end
  end
  
  it "sets the position of a player" do
    subject.set_position_of(2, 20)
    subject.position_of(2).should == 20
  end
  
  describe "winner" do
    it "returns nil if there is no winner" do
      subject.winner.should be_nil
    end
  
    it "returns the player on square 100" do
      subject.set_position_of(2, 100)
      subject.winner.should == 2
    end
  end
end

describe Board do
  subject { Board.new({3 => 7})}
  
  describe "resulting_square" do
    it "returns the passed in square for a normal square" do
      subject.resulting_square(2).should == 2
    end
    
    it "returns the end of a tunnel if the square is the start of the tunnel" do
      subject.resulting_square(3).should == 7
    end
    
    it "bounces the player back if beyond square 100" do
      subject.resulting_square(99).should == 99
      subject.resulting_square(100).should == 100
      subject.resulting_square(101).should == 99
      subject.resulting_square(102).should == 98
      subject.resulting_square(103).should == 97
      subject.resulting_square(104).should == 96
    end
  end
end
