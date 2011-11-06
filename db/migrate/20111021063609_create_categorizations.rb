class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.integer :media_id
      t.integer :subcategory_id

      t.timestamps
    end
  end
end
