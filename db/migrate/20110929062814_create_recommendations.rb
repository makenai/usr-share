class CreateRecommendations < ActiveRecord::Migration
  def self.up
    create_table :recommendations do |t|
      t.integer :type_id
      t.string :title
      t.string :isbn
      t.string :asin
      t.text :description
      t.string :url
      t.timestamps
    end
  end

  def self.down
    drop_table :recommendations
  end
end
