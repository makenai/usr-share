require 'csv'
require 'prawn/labels'
require 'shapes'

class MediaController < ApplicationController
  
  before_filter :authenticate_admin!, :except => [ :index, :show, :search ]

  def index
    media_query = Media.order('title ASC').includes(:publisher,:authors)
    if params[:subcategory_id]
      media_query = media_query.where( 'subcategory_id = :subcategory_id', subcategory_id: params[:subcategory_id] )
    end
    @media = media_query.page( params[:page] ).per( 24 )
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
    @search = Media.search do
      fulltext params[:term]
      facet(:category)
      with(:category, params[:category]) if params[:category].present?
      facet(:subcategory)
      with(:subcategory, params[:subcategory]) if params[:subcategory].present?
      paginate :page => params[:page]
    end
    # @media = Media.where(["title LIKE :term", { :term => "%#{term}%" }]).order('title ASC').page( params[:page] )
    @media = @search.results
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
      # if row[7]
        begin
          if media = Media.amazon_lookup( row[0] )
            media.location_id = on_order.try(:id)
            if media.save
              count += 1
            else
              puts "Could not save #{row[0]}"
              media.errors.each do |atr,msg|
                puts "\t#{atr} #{msg}"
              end
            end
          else
            puts "Could not find #{row[0]}"
          end
        rescue Media::LookupException => e
          puts e.message
        end
      # end
    end
    redirect_to media_index_url, :notice => "Imported #{count} items."
  end
  
  def inventory
    since = params[:since].blank? ? '2011-11-01' : params[:since]
    @media = Media.where('created_at > :since', :since => since )
    unless params[:ids].blank?
      list = params[:ids].split("\n").collect { |id| id.chomp }
      @media = @media.where('asin IN (:list) OR isbn IN (:list)', :list => list )
    end    
    respond_to do |format|
      format.html do
        render :layout => false
      end
      format.csv do
        csv = CSV.generate do |csv|
          csv << [ 'cat', 'subcat', 'auth', 'title', 'author' ]
          @media.each do |media|
            csv << [ *media.label, media.title, media.authors.try(:first) ]
          end
        end
        render :text => csv
      end
    end
  end

  def quick_labels
    labels = params[:labels].split("\n")
    if params[:skip]
      params[:skip].to_i.times do
        labels.unshift( nil )
      end
    end
    doc = Prawn::Labels.generate( labels, :type => "3M3100P" ) do |pdf, label, info|

      next unless label
      parts = label.split(' ')
      category = Category.find_by_code( parts.first )
      next unless category

      # Color Strip
      pdf.fill_color( category.color || 'ff00ff' )
      pdf.fill_rectangle [ 0, info[:height] - 6], info[:width], 3

      shape = category.shape
      # Shapes
      pdf.translate( 0, -3.5 ) do
        pdf.send("#{shape}_shape")
      end
      pdf.translate( info[:width] - 45.36, -3.5 ) do
        pdf.send("#{shape}_shape")
      end
        
      # Text
      pdf.fill_color( '000000' )
      pdf.font("Helvetica")
      pdf.font_size(10)
      pdf.move_down 17.5
      label.split(' ').each do |label|
        pdf.move_up 2
        pdf.text label, :align => :center, :character_spacing => 1, :style => :bold
      end
    end    
    send_data doc.render, filename: "labels.pdf",
                          type: "application/pdf",
                          disposition: "inline"
    
  end

  def labels
    since = Date.parse( params[:since] )
    media = Media.where('subcategory_id IS NOT NULL AND created_at > :since', :since => since )    

    unless params[:ids].blank?
      list = params[:ids].split("\n").collect { |id| id.chomp }
      media = media.where('asin IN (:list) OR isbn IN (:list)', :list => list )
    end
    
    media = media.includes( :subcategory )
    .sort { |a,b| a.label.to_s <=> b.label.to_s }
    
    @media = media.select do |media|
        show = true
        unless params[:category].blank?
          show = false unless media.subcategory.category.code.downcase == params[:category].downcase
        end
        unless params[:color].blank?
          show = false unless media.subcategory.category.color.downcase == params[:color].downcase
        end
        show
      end
      # Skip Label Support
      if params[:skip]
        params[:skip].to_i.times do
          @media.unshift(nil)
        end
      end
    doc = Prawn::Labels.generate( @media, :type => "3M3100P" ) do |pdf, media, info|
      next unless media
      # Color Strip
      pdf.fill_color( media.subcategory.category.color || 'ff00ff' )
      pdf.fill_rectangle [ 0, info[:height] - 6], info[:width], 3

      shape = media.subcategory.category.shape
      # Shapes
      pdf.translate( 0, -3.5 ) do
        pdf.send("#{shape}_shape")
      end
      pdf.translate( info[:width] - 45.36, -3.5 ) do
        pdf.send("#{shape}_shape")
      end
        
      # Text
      pdf.fill_color( '000000' )
      pdf.font("Helvetica")
      pdf.font_size(10)
      pdf.move_down 17.5
      media.label.each do |label|
        pdf.move_up 2
        pdf.text label, :align => :center, :character_spacing => 1, :style => :bold
      end
    end    
    send_data doc.render, filename: "labels.pdf",
                          type: "application/pdf",
                          disposition: "attachment"
  end
       
end
