class FloorsController < ApplicationController

  # GET /:building_slug/:id
  def show
    @floor = Floor.find(params[:id])
  end

  private
    def floor_params
      params.require(:floor).permit(:name, :slug, :level, :building)
    end
end
