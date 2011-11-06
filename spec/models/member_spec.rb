require File.dirname(__FILE__) + '/../spec_helper'

describe Member do
  
  it "can expire" do
    member = Member.new()
    member.active?.should == false
    member.valid_until = Time.now + 365.days
    member.active?.should == true
  end
  
end