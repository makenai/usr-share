class AddVoteCacheToRecommendation < ActiveRecord::Migration

  def up
    add_column :recommendations, :cached_votes_total, :integer, :default => 0
    add_column :recommendations, :cached_votes_up, :integer, :default => 0
    add_column :recommendations, :cached_votes_down, :integer, :default => 0
    add_index  :recommendations, :cached_votes_total
    add_index  :recommendations, :cached_votes_up
    add_index  :recommendations, :cached_votes_down
  end
  
  def down
    remove_column :recommendations, :cached_votes_total
    remove_column :recommendations, :cached_votes_up
    remove_column :recommendations, :cached_votes_down
  end
  
end
