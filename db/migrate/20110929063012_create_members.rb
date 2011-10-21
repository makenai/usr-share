class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.integer :user_id
      t.string :name
      t.string :nickname
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :postal
      t.string :country
      t.string :phone
      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
