require 'prawn/labels'
require 'shapes'
require 'csv'

class CategoriesController < ApplicationController

  before_filter :authenticate_admin!

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      if request.xhr?
        render :json => @category
      else
        redirect_to categories_url, :notice => "Successfully created category."
      end
    else
      if request.xhr?
        render :json => { error: @category.errors.to_a.join(', ') }
      else
        render :action => 'new'
      end
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to categories_url, :notice  => "Successfully updated category."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_url, :notice => "Successfully destroyed category."
  end
  
  def import
    csv = CSV.parse( params[:file].read, :headers => true )
    current_category = nil
    csv.each do |row|
      if row[0] && row[1]
        current_category = Category.find_or_create_by_code( row[1] )
        current_category.name = row[0]
        current_category.save( :validate => false )
      end
      if row[2] && row[3]
        subcategory = Subcategory.find_or_create_by_code_and_category_id( row[2], current_category.id )
        subcategory.name = row[3]
        subcategory.save( :validate => false )
      end
    end
    redirect_to categories_path
  end
  
  def export
    csv = CSV.generate do |csv|
      csv << [ 'Subject', 'Letter Code', 'Number Code', 'Subcategory' ]
      Category.all.each do |category|
        csv << [ category.name, category.code ]
        category.subcategories.each do |subcategory|
          csv << [ nil, nil, subcategory.code, subcategory.name ]
        end
      end
    end
    send_data( csv, :filename => 'categories.csv', :type => 'text/csv' )
  end
  
  def labels
    @categories = Category.all
    doc = Prawn::Labels.generate( @categories, :type => "SHELF" ) do |pdf, category, info|
        pdf.stroke_bounds
        pdf.fill_color(category.color)
        pdf.send("#{category.shape}_shape")
        pdf.fill_color( '000000' )
        pdf.font("Helvetica")
        pdf.font_size(40)
        pdf.move_down 20
        pdf.text category.to_s, :align => :center, :character_spacing => 1, :style => :bold
    end
    send_data doc.render, filename: "labels.pdf",
                          type: "application/pdf",
                          disposition: "inline"    
    # @media = Media.where('subcategory_id IS NOT NULL').includes( :subcategory ).sort { |a,b| a.label.to_s <=> b.label.to_s }
    # doc = Prawn::Labels.generate( @media, :type => "3M3100P" ) do |pdf, media, info|
    #   # Black Background
    #   # pdf.fill_color( '000000' )
    #   # pdf.fill_rectangle [ 0, 0 ], info[:width], 0 - info[:height]
    #   
    #   # Color Strip
    #   pdf.fill_color( media.subcategory.category.color || 'ff00ff' )
    #   pdf.fill_rectangle [ 0, info[:height] - 6], info[:width], 3
    # 
    #   shape = media.subcategory.category.shape
    #   # Shapes
    #   pdf.translate( 0, -3.5 ) do
    #     pdf.send("#{shape}_shape")
    #   end
    #   pdf.translate( info[:width] - 45.36, -3.5 ) do
    #     pdf.send("#{shape}_shape")
    #   end
    #     
    #   # Text
    #   pdf.fill_color( '000000' )
    #   pdf.font("Helvetica")
    #   pdf.font_size(10)
    #   pdf.move_down 17.5
    #   media.label.each do |label|
    #     pdf.move_up 2
    #     pdf.text label, :align => :center, :character_spacing => 1, :style => :bold
    #   end
    # end    
    # send_data doc.render, filename: "labels.pdf",
    #                       type: "application/pdf",
    #                       disposition: "inline"
  end
  
  
  def contents
  end
  
end
