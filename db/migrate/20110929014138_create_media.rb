class CreateMedia < ActiveRecord::Migration
  def self.up
    create_table :media do |t|
      t.integer :type_id
      t.integer :subcategory_id
      t.integer :publisher_id
      t.integer :location_id
      t.string :title
      t.string :isbn
      t.string :asin
      t.text :description
      t.string :image_url
      t.timestamps
    end
  end

  def self.down
    drop_table :media
  end
end
