class Post < ActiveRecord::Base
  attr_accessible :title, :body, :user_id
  default_scope :order => 'created_at DESC'  
  belongs_to :user
end
