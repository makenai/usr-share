class MediaLocationsController < ApplicationController
  
  before_filter :authenticate_admin!
  
  def index
    @media_locations = MediaLocation.all
  end

  def show
    @media_location = MediaLocation.find(params[:id])
  end

  def new
    @media_location = MediaLocation.new
  end

  def create
    @media_location = MediaLocation.new(params[:media_location])
    if @media_location.save
      redirect_to @media_location, :notice => "Successfully created media location."
    else
      render :action => 'new'
    end
  end

  def edit
    @media_location = MediaLocation.find(params[:id])
  end

  def update
    @media_location = MediaLocation.find(params[:id])
    if @media_location.update_attributes(params[:media_location])
      redirect_to @media_location, :notice  => "Successfully updated media location."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @media_location = MediaLocation.find(params[:id])
    @media_location.destroy
    redirect_to media_locations_url, :notice => "Successfully destroyed media location."
  end
end
