class Recommendation < ActiveRecord::Base
  attr_accessible :title, :description, :url, :media_id, :user_id
  validates_presence_of :title, :description, :url, :user_id
  belongs_to :user
end
