class Location < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :state, :postal, :country, :phone, :hours
end
