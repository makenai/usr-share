class Member < ActiveRecord::Base
  attr_accessible :user_id, :name, :address_1, :address_2, :city, :state, :postal, :country, :phone, :card_number, :valid_until, :confirmation
  belongs_to :user
  validates_presence_of :name, :address_1, :city, :state, :postal, :country, :phone
  validates_acceptance_of :confirmation
  
  def active?
    valid_until.is_a?( Time ) && valid_until > Time.now
  end
  
end
