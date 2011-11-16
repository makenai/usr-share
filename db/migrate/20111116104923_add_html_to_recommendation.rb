class AddHtmlToRecommendation < ActiveRecord::Migration
  def change
    add_column :recommendations, :html, :text
  end
end
