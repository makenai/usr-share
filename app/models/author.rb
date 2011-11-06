class Author < ActiveRecord::Base
  attr_accessible :name
  has_many :authorships
  has_many :media, :through => :authorships
  
  def to_s
    self.name
  end
  
end
