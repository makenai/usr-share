class Media < ActiveRecord::Base
  belongs_to :publisher
  has_many :authorships, :dependent => :destroy
  has_many :authors, :through => :authorships
    
  attr_accessible :type_id, :subcategory_id, :location_id, :title, :publisher_id, :isbn, :asin, :description, :image_url
  
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
      media.authors << author
    end
    media
  end
  
  
end
