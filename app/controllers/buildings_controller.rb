class BuildingsController < ApplicationController

  def show
    @building = Building.find(params[:id])
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def building_params
      params.require(:building, :id)
    end
end
