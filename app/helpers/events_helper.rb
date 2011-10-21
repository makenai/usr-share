module EventsHelper

  def options_for_room_select
    room_id = @room ? @room.id : nil
    options_from_collection_for_select(Room.all, 'id', 'name_and_location', room_id)
  end

  def room_name_and_location(event)
    if event.room_id.blank?
      'None'
    else
      event.room.name_and_location
    end
  end
end
