class AddCopyNumberToMedia < ActiveRecord::Migration
  def change
    add_column :media, :copy_number, :integer, :null => false, :default => 1
  end
end
