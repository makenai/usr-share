class Subcategory < ActiveRecord::Base
  belongs_to :category
  has_many :categorizations
  has_many :media, :through => :categorizations
end
