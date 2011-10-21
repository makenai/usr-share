class Event < ActiveRecord::Base
  belongs_to :room
  attr_accessible :name, :description, :url, :member_id, :room_id, :start_time, :duration, :is_promoted
end
