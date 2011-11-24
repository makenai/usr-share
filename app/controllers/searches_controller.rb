class SearchesController < ApplicationController
  def index
      query                     = params[:q]
      #page                      = params[:page]

      @search                   = Sunspot.search(Media) do
        fulltext params[:q]

        # facet(:card_tech)
        # with(:card_tech, params[:card_tech]) if params[:card_tech].present?
  end
end

end

