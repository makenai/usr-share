class Subcategory < ActiveRecord::Base
  attr_accessible :name, :code, :category_id
  belongs_to :category
  has_many :media
  validates_uniqueness_of :code, :scope => :category_id
  validates_presence_of :name, :code, :category_id  
  default_scope :order => 'code ASC'
    
  def full_name
    "#{category.code} #{self.code} - #{category.name} > #{self.name}"
  end
  
end
