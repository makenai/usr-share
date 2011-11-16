class Event < ActiveRecord::Base
  belongs_to :room
  belongs_to :member
  attr_accessible :name, :description, :url, :member_id, :room_id, :start_time, :duration, :is_promoted
  validates_presence_of :name, :room_id, :start_time, :member_id
  
  def end_time
    start_time + duration.hours
  end
  
end
