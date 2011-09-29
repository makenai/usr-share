class RecommendationsController < ApplicationController
  def index
    @recommendations = Recommendation.all
  end

  def show
    @recommendation = Recommendation.find(params[:id])
  end

  def new
    @recommendation = Recommendation.new
  end

  def create
    @recommendation = Recommendation.new(params[:recommendation])
    if @recommendation.save
      redirect_to @recommendation, :notice => "Successfully created recommendation."
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
      redirect_to @recommendation, :notice  => "Successfully updated recommendation."
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
