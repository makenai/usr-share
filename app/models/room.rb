class Room < ActiveRecord::Base
  belongs_to :location
  attr_accessible :name, :location_id, :capacity
end
