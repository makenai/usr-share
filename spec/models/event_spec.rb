require File.dirname(__FILE__) + '/../spec_helper'

describe Event do
  
  before(:each) do
    @event = Event.new(
      :name       => 'An Event',
      :room_id    => 1,
      :member_id  => 1,
      :duration   => 1,
      :start_time => Date.today().to_time + 10.days
    )
  end
  
  it "knows its end date" do
    start_time = Time.now
    duration = 3
    end_time = start_time + duration.hours
    e = Event.new( :start_time => start_time, :duration => duration )
    e.end_time.should == end_time
  end

  it "can't be booked in the past" do
    @event.start_time = Time.now() - 1.day
    @event.valid?.should == false
  end
 
  it "can't be booked on the same day" do
    @event.start_time = Time.now()
    @event.valid?.should == false
    
    @event.start_time = Time.now() + 1.day
    @event.valid?.should == true
  end
  
  it "is limited to one per day, per member" do
    @event.valid?.should == true
    @event.save
    
    secondEvent = Event.new( @event.attributes )
    secondEvent.start_time += 2.hours
    
    secondEvent.valid?.should == false
    
    secondEvent.member_id = 2
    secondEvent.valid?.should == true
    
    secondEvent.member_id = @event.member_id
    secondEvent.valid?.should == false
    
    secondEvent.start_time = secondEvent.start_time + 1.day
    secondEvent.valid?.should == true
  end

  it "is limited to three hours" do
    @event.duration = 3
    @event.valid?.should == true

    @event.duration = 4
    @event.valid?.should == false
  end
  
  it "is limited to two per user per month" do
    @event.valid?.should == true
    @event.save
    
    secondEvent = Event.new( @event.attributes )
    secondEvent.start_time += 2.days
    
    secondEvent.valid?.should == true
    secondEvent.save
    
    thirdEvent = Event.new( @event.attributes )
    thirdEvent.start_time += 4.days
    
    thirdEvent.valid?.should == false

    thirdEvent.start_time += 1.month
    thirdEvent.valid?.should == true
  end
  
  it "doesn't allow overlapping with other events" do
    @event.valid?.should == true
    @event.save
    
    secondEvent = Event.new( @event.attributes )
    secondEvent.member_id = 2

    # Same time as an event
    secondEvent.valid?.should == false

    # Ending at the time another event starts
    secondEvent.start_time -= 1.hour
    secondEvent.valid?.should == true

    # Running into an event's start time
    secondEvent.duration = 2
    secondEvent.valid?.should == false
    
    # Completely overlaping an event
    secondEvent.duration = 3
    secondEvent.valid?.should == false
    
  end
  
end