class Event < ActiveRecord::Base
  attr_accessible :name, :description, :url, :member_id, :room_id, :start_time, :duration, :is_promoted
end
