require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  
  it "can be an admin" do
    u = User.new()
    u.admin?.should == false
    u.admin = true
    u.admin?.should == true    
  end
  
  it "can have a membership" do
    u = User.new()
    u.member?.should == false
    u.member = Member.new()
    u.member?.should == false
    u.member.stub(:active?).and_return(true)
    u.member?.should == true
  end
  
  
end