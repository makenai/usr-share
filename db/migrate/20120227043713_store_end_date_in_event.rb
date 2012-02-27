class StoreEndDateInEvent < ActiveRecord::Migration
  def up
    add_column :events, :end_time, :datetime
    Event.all.each do |event|
      event.update_attribute( :end_time, event.start_time + (event.duration || 0).hours )
    end
  end

  def down
    remove_column :events, :end_time
  end
end
