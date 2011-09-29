class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :url
      t.integer :member_id
      t.integer :room_id
      t.datetime :start_time
      t.integer :duration
      t.boolean :is_promoted
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
