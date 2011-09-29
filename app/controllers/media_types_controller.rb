class MediaTypesController < ApplicationController
  def index
    @media_types = MediaType.all
  end

  def show
    @media_type = MediaType.find(params[:id])
  end

  def new
    @media_type = MediaType.new
  end

  def create
    @media_type = MediaType.new(params[:media_type])
    if @media_type.save
      redirect_to @media_type, :notice => "Successfully created media type."
    else
      render :action => 'new'
    end
  end

  def edit
    @media_type = MediaType.find(params[:id])
  end

  def update
    @media_type = MediaType.find(params[:id])
    if @media_type.update_attributes(params[:media_type])
      redirect_to @media_type, :notice  => "Successfully updated media type."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @media_type = MediaType.find(params[:id])
    @media_type.destroy
    redirect_to media_types_url, :notice => "Successfully destroyed media type."
  end
end
