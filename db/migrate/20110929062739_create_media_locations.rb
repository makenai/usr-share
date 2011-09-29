class CreateMediaLocations < ActiveRecord::Migration
  def self.up
    create_table :media_locations do |t|
      t.string :name
      t.boolean :available
      t.timestamps
    end
  end

  def self.down
    drop_table :media_locations
  end
end
