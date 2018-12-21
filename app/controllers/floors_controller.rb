class FloorsController < ApplicationController

  def show
    building = Building.find_by_slug!(params[:building_slug])
    @floor = Floor.find_by!(building_id: building.id, slug: params[:slug])
    @floor.building = building

    @toilets = Toilet.where(building_id: building.id, floor_id: @floor.id)
  end

  private
    def floor_params
      params.require(:floor).permit(:name, :slug, :level, :building, :building_slug)
    end
end
