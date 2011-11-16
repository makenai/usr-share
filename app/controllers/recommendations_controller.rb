class RecommendationsController < ApplicationController
  
    before_filter :authenticate_admin!, :only => [ :edit, :update, :destroy ]
  
  def index
    @recommendations = Recommendation.page(params[:page])
  end

  def show
    @recommendation = Recommendation.find(params[:id])
  end

  def new
    @recommendation = Recommendation.new
  end

  def create
    @recommendation = Recommendation.new(params[:recommendation])
    @recommendation.user_id = current_user.id
    if @recommendation.save
      redirect_to recommendations_url, :notice => "Successfully created recommendation."
    else
      render :action => 'new'
    end
  end

  def edit
    @recommendation = Recommendation.find(params[:id])
  end

  def update
    @recommendation = Recommendation.find(params[:id])
    if @recommendation.update_attributes(params[:recommendation])
      redirect_to recommendations_url, :notice  => "Successfully updated recommendation."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @recommendation = Recommendation.find(params[:id])
    @recommendation.destroy
    redirect_to recommendations_url, :notice => "Successfully destroyed recommendation."
  end
end
