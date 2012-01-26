class Event < ActiveRecord::Base
  belongs_to :room
  belongs_to :member
  attr_accessible :name, :description, :url, :member_id, :room_id, :start_time, :duration, :is_promoted
  validates_presence_of :name, :room_id, :start_time, :member_id
  
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
  
end
