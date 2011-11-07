class Media < ActiveRecord::Base
  belongs_to :publisher
  has_many :authorships, :dependent => :destroy
  has_many :authors, :through => :authorships
  accepts_nested_attributes_for :authorships  
    
  attr_accessible :type_id, :subcategory_id, :location_id, :title, :publisher_id, :isbn, :asin, 
    :description, :image_url, :copy_number, :authorships_attributes, :authors_attributes
  validates_uniqueness_of :asin, :scope => :copy_number
  validates_uniqueness_of :isbn, :scope => :copy_number
  validates_presence_of :title
  
  def self.from_amazon_item( item )
    media = self.new(
      :title       => item.get_unescaped('ItemAttributes/Title'),
      :description => item.get_unescaped('EditorialReviews[1]/EditorialReview/Content'),
      :isbn        => item.get_unescaped('ItemAttributes/ISBN'),
      :asin        => item.get_unescaped('ASIN'),
      :image_url   => item.get_unescaped('LargeImage/URL')
    )

    if publisher = Publisher.find_or_create_by_name( item.get_unescaped('ItemAttributes/Publisher') )
      media.publisher = publisher
    end

    authors = item.get_elements('ItemAttributes/Author') || []
    authors.each do |author_name|
      author = Author.find_or_create_by_name( author_name.get_unescaped() )
      media.authorships.build( :author_id => author.id )
    end
    media
  end
  
  def image_url
    read_attribute(:image_url) || 'default_media.png'
  end
  
  
end
