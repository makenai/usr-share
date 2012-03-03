class Event < ActiveRecord::Base
  belongs_to :room
  belongs_to :member
  attr_accessible :name, :description, :url, :member_id, :room_id, :start_time, :duration, :is_promoted, :policy, :created_at, :updated_at
  validates_presence_of :name, :room_id, :member_id, :duration, :start_time
  validates :start_time, :event_date => true, :unless => Proc.new { |e| e.user_is_admin }
  validates_acceptance_of :policy
  before_save :save_end_time
  after_save :send_event_notification
  attr_accessor :policy, :user_is_admin
  
  # Events that are not me.
  def other
    if self.new_record?
      Event.scoped
    else
      Event.where('id != ?', self.id)
    end
  end
  
  def end_time
    start_time + duration.hours
  end
  
  def starts_at
    start_time.to_datetime
  end
  
  def on
    "#{start_time.strftime("%a, %B %d")} from #{start_time.strftime("%I:%M %p")} to #{end_time.strftime("%I:%M %p")}"
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
    self.other.where( 'start_time < ? AND end_time > ?', self.end_time, self.start_time )
  end
  
  # We pretty much just store this for easy date comparisons in the db
  def save_end_time
    write_attribute( :end_time, self.end_time )
  end
  
  def send_event_notification
    StaffMailer.event_email( self ).deliver
  end
  
end
