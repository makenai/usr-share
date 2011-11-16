class PublishersController < ApplicationController
  
  before_filter :authenticate_admin!
  
  def index
    @publishers = Publisher.all
  end

  def show
    @publisher = Publisher.find(params[:id])
  end

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new(params[:publisher])
    if @publisher.save
      redirect_to @publisher, :notice => "Successfully created publisher."
    else
      render :action => 'new'
    end
  end

  def edit
    @publisher = Publisher.find(params[:id])
  end

  def update
    @publisher = Publisher.find(params[:id])
    if @publisher.update_attributes(params[:publisher])
      redirect_to @publisher, :notice  => "Successfully updated publisher."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @publisher = Publisher.find(params[:id])
    @publisher.destroy
    redirect_to publishers_url, :notice => "Successfully destroyed publisher."
  end
end
