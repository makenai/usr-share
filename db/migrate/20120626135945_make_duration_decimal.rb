class MakeDurationDecimal < ActiveRecord::Migration
  def up
    change_column :events, :duration, :decimal
  end

  def down
  end
end
