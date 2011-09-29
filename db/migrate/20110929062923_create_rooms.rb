class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.integer :location_id
      t.string :capacity
      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end
