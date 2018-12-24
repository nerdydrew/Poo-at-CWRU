class ToiletsController < ApplicationController
  before_action CASClient::Frameworks::Rails::Filter, except: :show

  def show
    building = Building.find_by_slug!(params[:building_slug])
    floor = Floor.find_by!(building_id: building.id, slug: params[:floor_slug])
    @toilet = Toilet.find_by!(building_id: building.id, floor_id: floor.id, slug: params[:slug])

    floor.building = building
    @toilet.building = building
    @toilet.floor = floor
  end

  def new
    @buildings = Building.all.eager_load(:floor).sort

    params[:building_id] = Building.where(slug: params[:building_slug]).limit(1).pluck(:id)
    params[:floor_id] = Floor.where(building_id: params[:building_id], slug: params[:floor_slug]).limit(1).pluck(:id)

    @toilet = Toilet.new
  end

  def create
    @toilet = Toilet.new(toilet_params)

    @toilet.slug = @toilet.name.parameterize
    @toilet.creator = session[:cas_user]

    if @toilet.save
      redirect_to [@toilet.building, @toilet.floor, @toilet], notice: 'Restroom was successfully created.'
    else
      @buildings = Building.all.eager_load(:floor).sort
      params[:building_id] = toilet_params[:building_id]
      params[:floor_id] = toilet_params[:floor_id]

      render :new
    end
  end

  private
    def toilet_params
      params.require(:toilet).permit(:name, :slug, :gender, :building, :building_id, :building_slug, :floor, :floor_id, :floor_slug, :stalls, :urinals, :sinks, :comments, :creator)
    end
end
