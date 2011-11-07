class Category < ActiveRecord::Base
  attr_accessible :name, :code
  has_many :subcategories
  validates_uniqueness_of :code
  default_scope :order => 'code ASC'
  
  
  def name_with_code
    "#{code} - #{name}"
  end
  
end
