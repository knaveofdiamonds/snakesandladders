require File.dirname(__FILE__) + '/spec_helper'

describe Board do
  
  def assert_position_from(from, to)
    Board.new({2 => 3}).position_from(from).should == to
  end
  
  describe "#position_from" do
    context "for a normal square" do
      it "returns the square" do
        assert_position_from(5, 5)
      end
    end
    
    context "for the start of a tunnel" do
      it "returns the end point of the tunnel" do
        assert_position_from(2, 3)
      end
    end
    
    context "past the win square" do
      it "bounces back by the amount over" do
        assert_position_from(103, 97)
      end
    end
  end
end
