class PlacesController < ApplicationController
  before_action :set_place, only: [:show]
 
  def index
  end

  def show
    render :show
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

    def set_place
      places = Rails.cache.read params[:city]
      @place = places.detect {|p| p.id.to_s == params[:id].to_s}
    end

end