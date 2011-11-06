class Category < ActiveRecord::Base
  has_many :subcategories
  
  def index
    render :text => 'Testing'
  end
  
end
