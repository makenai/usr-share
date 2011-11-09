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
  
  def contents
  end
  
end
