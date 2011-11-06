class SubcategoriesController < ApplicationController

  before_filter :authenticate_admin!

  def new
    @subcategory = Subcategory.new( params )
  end

  def create
    @subcategory = Subcategory.new(params[:subcategory])
    if @subcategory.save
      redirect_to categories_url, :notice => "Successfully created subcategory."
    else
      render :action => 'new'
    end
  end

  def edit
    @subcategory = Subcategory.find(params[:id])
  end

  def update
    @subcategory = Subcategory.find(params[:id])
    if @subcategory.update_attributes(params[:subcategory])
      redirect_to categories_url, :notice  => "Successfully updated subcategory."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @subcategory = Subcategory.find(params[:id])
    @subcategory.destroy
    redirect_to categories_url, :notice => "Successfully destroyed subcategory."
  end
end
