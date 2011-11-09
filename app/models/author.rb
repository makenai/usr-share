class Author < ActiveRecord::Base
  attr_accessible :name
  has_many :authorships
  has_many :media, :through => :authorships
  
  def to_s
    self.name
  end
  
  def last_name
    self.name.split(/\s+/)[-1]
  end
  
  def short
    self.last_name.upcase[0..2]
  end
  
end
