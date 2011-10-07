class Location < ActiveRecord::Base
  has_many :rooms
  
  attr_accessible :name, :address_1, :address_2, :city, :state, :postal, :country, :phone, :hours
  
  # Return the address in a google maps compatible address format
  def to_url_param
    CGI.escape([ address_1, city, state, postal, country ].select { |l| !l.empty? }.join(',') )
  end
  
end
