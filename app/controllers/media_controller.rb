class MediaController < ApplicationController

  before_filter :authenticate_admin!, :only => [ :new, :create, :edit, :update, :destroy ]

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
    redirect_to media_index_url, :notice => "Successfully destroyed media."
  end
  
  def search
    term = params[:term]
    @media = Media.where(["title LIKE :term OR description LIKE :term", { :term => "%#{term}%" }]) 
    render :action => 'index'
  end
  
  def scan
    code = params[:upc]
    response = if code.length >= 10
      Amazon::Ecs.item_lookup( code, :id_type => 'ISBN', :search_index => 'Books', :response_group => 'Large,AlternateVersions' )
    else
      Amazon::Ecs.item_lookup( code, :response_group => 'Large' )
    end
    if response
      item = response.items.first
      if item
        @media = Media.from_amazon_item( item )
        @duplicate_count = Media.where( :asin => @media.asin ).count
        if @duplicate_count > 0 && !params[:duplicate]
          return render :action => 'confirm_duplicate'
        else
          if @media.save
            redirect_to admin_path, :notice => "Imported #{@media.title}"
          else
            render :action => 'new'
          end
        end
      else
        @error = response.doc.to_s
        render :file => 'media/error'
      end
    end
    
  end
     
end
