class BuildingsController < ApplicationController

  def show
    @building = Building.find(params[:id])
  end

  def near_me
    @latitude = params[:latitude].to_f
    @longitude = params[:longitude].to_f

    if @latitude.present? and @longitude.present?
      @searched = true
      point = [@latitude, @longitude]
      @buildings = Building.all
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
