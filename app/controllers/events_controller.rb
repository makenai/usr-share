class EventsController < ApplicationController

  before_filter :authenticate_member!, :only => [ :new, :create, :edit, :update, :destroy ]
  before_filter :find_room, :only => [ :new ]

  def index
    @date = params[:month] ? Date.parse("#{params[:month]}-01") : Date.today
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
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
end
