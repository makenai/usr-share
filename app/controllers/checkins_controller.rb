class CheckinsController < ApplicationController
  
  before_filter :authenticate_admin!
  
  def index
    @checkins = Checkin.all
  end

  def show
    @checkin = Checkin.find(params[:id])
  end

  def new
    @checkin = Checkin.new
  end

  def create
    @checkin = Checkin.new(params[:checkin])
    if @checkin.save
      redirect_to @checkin, :notice => "Successfully created checkin."
    else
      render :action => 'new'
    end
  end

  def edit
    @checkin = Checkin.find(params[:id])
  end

  def update
    @checkin = Checkin.find(params[:id])
    if @checkin.update_attributes(params[:checkin])
      redirect_to @checkin, :notice  => "Successfully updated checkin."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @checkin = Checkin.find(params[:id])
    @checkin.destroy
    redirect_to checkins_url, :notice => "Successfully destroyed checkin."
  end
end
