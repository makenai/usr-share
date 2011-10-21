class Room < ActiveRecord::Base
  belongs_to :location
  attr_accessible :name, :location_id, :capacity

  def name_and_location
    if location_id.blank?
      name
    else
      "#{name} (#{location.name})"
    end
  end
end
