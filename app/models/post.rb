class Post < ActiveRecord::Base
  attr_accessible :title, :body
  default_scope :order => 'created_at DESC'  
end
