class AddExpirationAndCardNumberToMembers < ActiveRecord::Migration
  def change
    add_column :members, :card_number, :string, :default => nil
    add_column :members, :valid_until, :datetime, :default => nil
  end
end
