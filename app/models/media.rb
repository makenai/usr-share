class Media < ActiveRecord::Base
  attr_accessible :type_id, :subcategory_id, :location_id, :title, :isbn, :asin, :description
end
