require 'csv'

class MediaController < ApplicationController
  
  before_filter :authenticate_admin!, :only => [ :new, :create, :edit, :update, :destroy, :import ]

  def index
    @media = Media.order('title ASC').includes(:publisher,:authors).page( params[:page] )
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
      if params[:redirect_to]
        redirect_to params[:redirect_to]
      else
        redirect_to @media, :notice  => "Successfully updated media."
      end
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
    @media = Media.where(["title LIKE :term", { :term => "%#{term}%" }]).order('title ASC').page( params[:page] )
    render :action => 'index'
  end
  
  def scan
    @media = Media.amazon_lookup( params[:upc] )
    if @media.save
      redirect_to admin_path, :notice => "Imported #{@media.title}"
    else
      render :action => 'new'
    end
  rescue Media::LookupException => e
    @error = e.message
    render :file => 'media/error'
  end
  
  def categorize
    @queue_count = Media.where('subcategory_id IS NULL').count()
    @media = Media.where('subcategory_id IS NULL').offset( params[:skip].to_i ).first
  end
  
  def import
    count = 0
    on_order = MediaLocation.find_by_name('On Order')
    csv = CSV.parse( params[:file].read, :headers => true )
    csv.each do |row|
      if row[7]
        begin
          if media = Media.amazon_lookup( row[7] )
            media.location_id = on_order.try(:id)
            if media.save
              count += 1
            end
          end
        rescue Media::LookupException => e
          puts e.message
        end
      end
    end
    redirect_to media_index_url, :notice => "Imported #{count} items."
  end
       
end
