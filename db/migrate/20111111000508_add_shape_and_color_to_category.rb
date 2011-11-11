class AddShapeAndColorToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :shape, :string
    add_column :categories, :color, :string
    
    
    categories = Category.all
    Category::LABEL_SHAPES.each do |shape|
      Category::LABEL_COLORS.each do |color|
        category = categories.shift
        if category
          category.update_attributes( shape: shape, color: color )
          puts "#{category} - #{shape} - #{color}" 
        end
      end
    end
    
  end
end