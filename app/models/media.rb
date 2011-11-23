class Media < ActiveRecord::Base
  belongs_to :publisher
  belongs_to :subcategory
  has_many :authorships, :dependent => :destroy
  has_many :authors, :through => :authorships
  accepts_nested_attributes_for :authorships
  default_scope :order => 'title ASC'

  attr_accessible :type_id, :subcategory_id, :location_id, :title, :publisher_id, :isbn, :asin, 
    :description, :image_url, :copy_number, :authorships_attributes, :authors_attributes
  validates_uniqueness_of :asin, :scope => :copy_number
  validates_uniqueness_of :isbn, :scope => :copy_number
  validates_presence_of :title
  
  #for solr search
  searchable do
    text :title, :boost => 2
    
    text :description
    string :subcategory #for faceted search
  end    
  
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
  
  class LookupException < Exception; end
  
  def self.get_amazon_response( code )
    if code.length >= 10
      return Amazon::Ecs.item_lookup( code, :id_type => 'ISBN', :search_index => 'Books', :response_group => 'Large,AlternateVersions' )
    else
      return Amazon::Ecs.item_lookup( code, :response_group => 'Large' )
    end
  rescue Exception => e
    raise LookupException.new( e.message )    
  end
  
  def self.amazon_lookup( code )
    response = self.get_amazon_response( code )
    if item = response.items.first
      return self.from_amazon_item( item )
    else
      raise LookupException.new( response.doc.to_s )
    end
  end
  
  def amazon_categories
    categories = []
    response = self.class.get_amazon_response( self.asin || self.isbn )
    item = response.items.first
    return categories unless item
    if nodes = item.get_elements('BrowseNodes/BrowseNode')
      nodes.each do |node|
        node_ancestry = [{
          :name    => node.get_unescaped('Name'),
          :node_id => node.get('BrowseNodeId')
        }]
        current_node = node
        while next_node = current_node.get_element('Ancestors/BrowseNode')
          node_ancestry.unshift({
            :name    => next_node.get_unescaped('Name'),
            :node_id => next_node.get('BrowseNodeId')
          })
          current_node = next_node
        end
        categories << node_ancestry
      end
    end
    return categories
  end
  
  def category_id
    subcategory.try(:category_id)
  end
    
  def label
    return [ '', '', '' ] unless subcategory
    [ subcategory.category.code, subcategory.code, authors.empty? ? '' : authors.first.short ]
  end


end