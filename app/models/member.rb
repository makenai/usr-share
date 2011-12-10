class Member < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, :address_1, :city, :state, :postal, :country, :phone
  validates_acceptance_of :confirmation

  attr_accessor :send_pickup_email, :card_number, :confirmation,
                :card_cvc, :card_expiry_month, :card_expiry_year

  attr_accessible :user_id, :name, :address_1, :address_2, :city, :state, :postal,
                  :country, :phone, :card_number, :valid_until, :company, :confirmation,
                  :notes, :send_pickup_email, :card_number, :card_cvc,
                  :card_expiry_month, :card_expiry_year

  def self.create_stripe_token(member)
    unless ENV["STRIPE_API_KEY"].nil?
      Stripe::Token.create(
        card: {
          number: member.card_number,
          exp_month: member.card_expiry_month,
          exp_year: member.card_expiry_year,
          cvc: member.card_cvc },
        amount: 2500,
        currency: "usd")
    else
      Struct::StripeToken.new(
        rand(10000),
        Struct::StripeCreditCard.new(
          member.card_number,
          member.card_expiry_month,
          member.card_expiry_year,
          member.card_cvc,
          "1234", "Visa"),
        2500, "usd")
    end
  end

  def self.charge_stripe_token(token, member)
    if Rails.env == "production"
      Stripe::Charge.create(
        amount: token.amount,
        currency: token.currency,
        card: token.id,
        description: "Membership charge for /usr/lib.")
    end

    member.registration_amount = token.amount
    member.stripe_token = token.id
    member.card_last_four = token.card.last4
    member.card_type = token.card.type

    member
  end

  def active?
    valid_until.is_a?(Time) && valid_until > Time.now
  end
end
