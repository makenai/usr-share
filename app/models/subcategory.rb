class Subcategory < ActiveRecord::Base
  attr_accessible :name, :code, :category_id
  belongs_to :category
  has_many :categorizations
  has_many :media, :through => :categorizations
  validates_uniqueness_of :code, :scope => :category_id
  default_scope :order => 'code ASC'
    
  def full_name
    "#{category.code} #{self.code} - #{category.name} > #{self.name}"
  end
  
end
