require 'spec_helper'

describe Game do
  subject { Game.new(3, board) }
  let(:board) { stub(:resulting_square => 1) }
  
  context "in its initial state" do
    it "has all players in position 0" do
      subject.position_of(1).should == 0
      subject.position_of(2).should == 0
      subject.position_of(3).should == 0
    end
  end
  
  describe "rolling" do
    it "moves the current player according to the rules of the board" do
      board.should_receive(:resulting_square).with(5).and_return(7)
      subject.roll(5)
      subject.position_of(1).should == 7
    end
    
    it "makes it the next player's go" do
      subject.current_player.should == 1
      subject.roll(5)
      subject.current_player.should == 2
      subject.roll(5)
      subject.current_player.should == 3
      subject.roll(5)
      subject.current_player.should == 1
    end
    
    it "gives the current player another go if they roll a 6" do
      subject.current_player.should == 1
      subject.roll(6)
      subject.current_player.should == 1
    end
  end
  
  it "sets the player's position to the correct square" do
    subject.set_position(2, 20)
    subject.position_of(2).should == 20
  end
  
  it "returns the winner as the person on square 100" do
    subject.winner.should be_nil
    subject.set_position(2, 100)
    subject.winner.should == 2
  end
end

describe Board do
  subject { Board.new({7 => 3})}
  
  describe "resulting_square" do
    it "returns the square passed in if it's a normal square" do
      subject.resulting_square(4).should == 4
    end
    
    it "returns the end of the tunnel if the square is the beginning of a tunnel" do
      subject.resulting_square(7).should == 3
    end
    
    it "bounces back if the square is over 100" do
      subject.resulting_square(99).should == 99
      subject.resulting_square(100).should == 100
      subject.resulting_square(101).should == 99
      subject.resulting_square(102).should == 98
      subject.resulting_square(103).should == 97
    end
  end
end
