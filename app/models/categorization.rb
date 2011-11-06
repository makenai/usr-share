class Categorization < ActiveRecord::Base
  belongs_to :media
  belongs_to :subcategory
end
