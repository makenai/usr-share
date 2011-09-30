class Media < ActiveRecord::Base
  belongs_to :publisher
  has_many :authorships
  has_many :authors, :through => :authorships
    
  attr_accessible :type_id, :subcategory_id, :location_id, :title, :publisher_id, :isbn, :asin, :description, :image_url
end
