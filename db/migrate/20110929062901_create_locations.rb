class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :postal
      t.string :country
      t.string :phone
      t.text :hours
      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
