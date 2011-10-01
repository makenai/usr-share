class Location < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :state, :postal, :country, :phone, :hours
  
  # Return the address in a google maps compatible address format
  def to_url_param
    CGI.escape([ address_1, address_2, city, state, postal, country ].join(',') )
  end
  
end
