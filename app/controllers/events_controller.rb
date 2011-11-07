class EventsController < ApplicationController

  before_filter :authenticate_member!, :only => [ :new, :create, :edit, :update, :destroy ]
  before_filter :find_room, :only => [ :new ]

  def index
    @date = params[:month] ? Date.parse("#{params[:month]}-01") : Date.today
    @events = Event.where( 'start_time > :cutoff', :cutoff => Time.now - 1.month ).order('start_time DESC').to_a
    respond_to do |format|
      format.html
      format.ics { render :text => render_ics( @events ) }
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new( :duration => 1 )
  end

  def create
    @event = Event.new(params[:event])
    @event.member_id = current_user.member.id
    if @event.save
      redirect_to @event, :notice => "Successfully created event."
    else
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to @event, :notice  => "Successfully updated event."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url, :notice => "Successfully destroyed event."
  end

  def find_room
    if params[:room_id]
      @room = Room.find(params[:room_id])
    end
  end
  
  private
  
  def render_ics( events )
    return RiCal.Calendar do
      events.each do |e|
        event do
          summary     e.name
          description e.description
          dtstart     e.start_time
          dtend       e.start_time + e.duration.hours
          location    "#{e.room.location.name} - #{e.room.name}"
        end
      end
    end
  end
  
end
