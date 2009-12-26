require File.dirname(__FILE__) + '/spec_helper'

describe BoardBuilder do
  context "building" do
    it "creates a new board" do
      BoardBuilder.new.build.should be_instance_of(Board)
    end
  end
  
  context "adding player" do
    it "adds a player at the given start point" do
      BoardBuilder.new.add_player(1, 20).build.position_of(1).should == 20
    end
    it "defaults a player to position 0" do
      BoardBuilder.new.add_player(1).build.position_of(1).should == 0
    end
  end
  
  context "adding a tunnel" do
    it "adds the tunnel to the board" do
      BoardBuilder.new.add_tunnel(3, 7).build.tunnel_at(3).should == 7
    end
  end
end
