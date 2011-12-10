class AddCardInformationToMember < ActiveRecord::Migration
  def change
    add_column :members, :registration_amount, :integer
    add_column :members, :stripe_token, :string
    add_column :members, :card_last_four, :string
    add_column :members, :card_type, :string
  end
end
