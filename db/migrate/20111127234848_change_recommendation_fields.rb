class ChangeRecommendationFields < ActiveRecord::Migration

  def up    
    remove_column :recommendations, :html
    add_column    :recommendations, :image_url, :string
    add_column    :recommendations, :notes, :text
    add_column    :recommendations, :user_title, :string
    Recommendation.all.each do |recommendation|
      recommendation.user_title = recommendation.title
      recommendation.notes = recommendation.description
      recommendation.save
    end
  end
  
  def down
    remove_column :recommendations, :user_title
    remove_column :recommendations, :notes
    remove_column :recommendations, :image_url
    add_column    :recommendations, :html, :text
  end
  
end
