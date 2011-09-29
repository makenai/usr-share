class Recommendation < ActiveRecord::Base
  attr_accessible :type_id, :title, :isbn, :asin, :description, :url
end
