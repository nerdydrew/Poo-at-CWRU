class BuildingsController < ApplicationController
  def show
    @building = Building.find_by_slug!(params[:slug])
  end

  def near_me
    latitude = params[:latitude].to_f
    longitude = params[:longitude].to_f

    if latitude.present? and longitude.present?
      @searched = true
      point = [latitude, longitude]
      @buildings = Building.near(point, 5).limit(5)
    end

    respond_to do |format|
      format.js {render layout: false} # Don't render layout for AJAX requests
      format.html {render}
    end
  end

  private
    def building_params
      params.require(:building).permit(:id, :latitude, :longitude)
    end
end
