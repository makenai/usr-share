class Event < ActiveRecord::Base
  belongs_to :room
  belongs_to :member
  attr_accessible :name, :description, :url, :member_id, :room_id, :start_time, :duration, :is_promoted
  validates_presence_of :name, :room_id, :member_id, :duration, :start_time
  validates :start_time, :event_date => true
  before_save :save_end_time
  
  def end_time
    start_time + duration.hours
  end
  
  def starts_at
    start_time.to_datetime
  end
  
  def ends_at
    end_time.to_datetime
  end
  
  def as_json(options={})
    data = {
      :id => self.id,
      :url => "http://usrlib.org/events/#{self.id}",
      :name => self.name,
      :description => self.description,
      :startDate => self.starts_at,
      :endDate => self.ends_at,
      :owner => self.member.user.name
    }
    data[:infoUrl] = self.url if self.url
    return data
  end
  
  def conflicting_events
    # http://stackoverflow.com/questions/143552/comparing-date-ranges/143568#143568
    # IsConflict(Datetime s1, Datetime e1, Datetime s2, Datetime e2)
    #   (s1 < e2) && (e1 > s2)
    Event.where( 'start_time < ? AND end_time > ?', self.end_time, self.start_time )
  end
  
  # We pretty much just store this for easy date comparisons in the db
  def save_end_time
    write_attribute( :end_time, self.end_time )
  end
  
end
