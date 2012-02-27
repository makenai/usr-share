class EventDateValidator < ActiveModel::EachValidator

  def validate_each(object, attribute, value)
    
    if object.start_time.to_date == Date.today()
      object.errors[ attribute ] << 'is invalid. Same day reservations are not accepted.'
    end
    
    if object.start_time < Time.now()
      object.errors[ attribute ] << 'is invalid. Cannot book an event in the past.'
    end

    if object.duration > 3
      object.errors[ :duration ] << 'is invalid. Reservations are limited to 3 hours.'
    end
    
    same_day_events = Event.where('member_id = ? AND substr(start_time,0,11) = ?', 
      object.member_id, object.start_time.to_date ).count
    if same_day_events >= 1
      object.errors[ attribute ] << 'is invalid. Reservations are limited to one (1) per day, per member (or group).'
    end

    same_month_events = Event.where('member_id = ? AND substr(start_time,0,8) = ?', 
      object.member_id, object.start_time.strftime('%Y-%m') ).count
    if same_month_events >= 2
      object.errors[ attribute ] << 'is invalid. Reservations are limited to two (2) per month, per member (or group).'
    end

    conflicts = object.conflicting_events
    if conflicts.count > 0
      object.errors[ attribute ] << 'conflicts with pre-existing events.'
    end

  end
  
end