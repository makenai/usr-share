require 'csv'
require 'prawn/labels'
require 'shapes'

class MediaController < ApplicationController
  
  before_filter :authenticate_admin!, :only => [ :new, :create, :edit, :update, :destroy, :import ]

  def index
    media_query = Media.order('title ASC').includes(:publisher,:authors)
    if params[:subcategory_id]
      media_query = media_query.where( 'subcategory_id = :subcategory_id', subcategory_id: params[:subcategory_id] )
    end
    @media = media_query.page( params[:page] )
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
    media_query = params[:subcategory_id] ? 
      Media.where('subcategory_id = :subcategory_id', subcategory_id: params[:subcategory_id] ) : 
      Media.where('subcategory_id IS NULL')
    media_query = media_query.order('asin ASC')
    if params[:start]
      media_query = media_query.where( 'asin > :asin', asin: params[:start] )
    end
    @queue_count = media_query.count()
    @media = media_query.offset( params[:skip].to_i ).first
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
  
  def inventory
    respond_to do |format|
      format.html
      format.csv do
        csv = CSV.generate do |csv|
          csv << [ 'cat', 'subcat', 'auth', 'title', 'author' ]
          Media.all.each do |media|
            csv << [ *media.label, media.title, media.authors.try(:first) ]
          end
        end
        render :text => csv
      end
    end
  end

  def labels
    @media = Media.where('subcategory_id IS NOT NULL').includes( :subcategory )
    doc = Prawn::Labels.generate( @media, :type => "3M3100P" ) do |pdf, media, info|
      # Black Background
      pdf.fill_color( '000000' )
      pdf.fill_rectangle [ 0, 0 ], info[:width], 0 - info[:height]
      
      # Color Strip
      pdf.fill_color( media.subcategory.category.color || 'ff00ff' )
      pdf.fill_rectangle [ 0, info[:height] ], info[:width], 9

      shape = media.subcategory.category.shape
      # Shapes
      pdf.translate( 0, -3.5 ) do
        pdf.send("#{shape}_shape")
      end
      pdf.translate( info[:width] - 45.36, -3.5 ) do
        pdf.send("#{shape}_shape")
      end
        
      # Text
      pdf.fill_color( 'FFFFFF' )
      pdf.font("Helvetica")
      pdf.font_size(10)
      pdf.move_down 18.5
      media.label.each do |label|
        pdf.move_up 2
        pdf.text label, :align => :center, :character_spacing => 1        
      end
    end    
    send_data doc.render, filename: "labels.pdf",
                          type: "application/pdf",
                          disposition: "inline"
  end
       
end
