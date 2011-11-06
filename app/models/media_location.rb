class MediaLocation < ActiveRecord::Base
  attr_accessible :name, :available
  validates_uniqueness_of :name
end
