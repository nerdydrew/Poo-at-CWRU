class BuildingsController < ApplicationController
  skip_before_action CASClient::Frameworks::Rails::GatewayFilter, only: :near_me

  def show
    @building = Building.find_by_slug!(params[:slug])
    @floor = Floor.where(building_id: @building.id, level: 1).take

    @toilets = Toilet.get_by_building(@user, @building.id)
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
