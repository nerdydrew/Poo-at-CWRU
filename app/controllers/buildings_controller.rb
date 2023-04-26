class BuildingsController < ApplicationController

  def index
    @buildings_by_letter = Building.all
      .left_joins(:restroom).group(:id)
      .select("buildings.*", "COUNT(restrooms.id) restroom_count")
      .sort_by  { | building | building.name.upcase }
      .group_by { | building | building.name.first.upcase }
  end

  def show
    @building = Building.find_by_slug!(params[:slug])
    @floor = Floor.where(building_id: @building.id, level: 1).take

    @restrooms = Restroom.get_by_building(@gender, @building.id)
    @display_floors = true
  end

  def near_me
    latitude = params[:latitude].to_f
    longitude = params[:longitude].to_f

    if latitude.present? and longitude.present?
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
