# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

User.create!(
  :name     => "Pawel",
  :email    => "pawel@zappos.com",
  :password => 'changeme'
)

usrlib = Location.create!(
  :name      => '/usr/lib',
  :address_1 => '520 E. Fremont St. #200',
  :city      => 'Las Vegas',
  :state     => 'NV',
  :postal    => '89144',
  :country   => 'USA',
  :phone     => '(702) 518-0098',
  :hours     => "Mon-Fri 7 am - 12 am\nSat 9 am - 12 am\nSun 9 am - 5 pm"
)

Room.create(
  :name        => 'Meeting Room',
  :location_id => usrlib.id,
  :capacity    => 30
)
