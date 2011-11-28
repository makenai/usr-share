require 'url_validator'

class Recommendation < ActiveRecord::Base
  attr_accessible :url, :user_title, :notes, :title, :description, :image_url, :media_id, :user_id,
    :cached_votes_total, :cached_votes_up, :cached_votes_down
  validates_presence_of :user_title, :notes, :user_id
  validates :url, :url => true, :presence => true
  belongs_to :user
  before_save :get_embedly
  
  scope :by_votes, :order => 'cached_votes_up - cached_votes_down DESC, created_at DESC'
  scope :latest, :order => 'created_at DESC', :limit => 9
  acts_as_votable
  
  def get_embedly
    embedly_api = Embedly::API.new(
      :key        => APP_CONFIG[:embedly_key],
      :user_agent => 'Mozilla/5.0 (compatible; usrshare/1.0; pawel@usrlib.org)'
    )
    if obj = embedly_api.oembed( :url => url )
      self.title       = obj[0].title
      self.description = obj[0].description
      self.image_url   = obj[0].thumbnail_url
    end
  end
  
  def image_url
    read_attribute(:image_url) || 'default_media.png'
  end
  
  def score
    count_votes_up - count_votes_down
  end
  
end
