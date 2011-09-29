class MediaController < ApplicationController
  def index
    @media = Media.all
  end

  def show
    @media = Media.find(params[:id])
  end

  def new
    @media = Media.new
  end

  def create
    @media = Media.new(params[:media])
    if @media.save
      redirect_to @media, :notice => "Successfully created media."
    else
      render :action => 'new'
    end
  end

  def edit
    @media = Media.find(params[:id])
  end

  def update
    @media = Media.find(params[:id])
    if @media.update_attributes(params[:media])
      redirect_to @media, :notice  => "Successfully updated media."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @media = Media.find(params[:id])
    @media.destroy
    redirect_to media_url, :notice => "Successfully destroyed media."
  end
  
  def search
    @media = Media.all
    render :action => 'index'
  end
  
end
