class SimplifyRecommendations < ActiveRecord::Migration
  def up
    remove_column :recommendations, :type_id
    remove_column :recommendations, :isbn
    remove_column :recommendations, :asin
    add_column :recommendations, :media_id, :integer
    add_column :recommendations, :user_id, :integer
  end

  def down
    add_column :recommendations, :type_id, :integer
    add_column :recommendations, :isbn, :string
    add_column :recommendations, :asin, :string
    remove_column :recommendations, :user_id
    remove_column :recommendations, :media_id    
  end
end
