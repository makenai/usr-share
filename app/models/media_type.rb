class MediaType < ActiveRecord::Base
  attr_accessible :name
  validates_uniqueness_of :name
end
