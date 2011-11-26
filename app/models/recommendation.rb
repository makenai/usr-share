require 'url_validator'

class Recommendation < ActiveRecord::Base
  attr_accessible :title, :description, :url, :media_id, :user_id, :html
  validates_presence_of :title, :description, :user_id
  validates :url, :url => true, :presence => true
  belongs_to :user
  before_save :get_embedly
  
  def get_embedly
    embedly_api = Embedly::API.new :user_agent => 'Mozilla/5.0 (compatible; usrshare/1.0; pawel@usrlib.org)'
    if obj = embedly_api.oembed( :url => url )
      self.html = obj[0].html
    end
  end
  
end
