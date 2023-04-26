class RestroomsController < ApplicationController
  before_action :require_login, except: :show
  before_action :set_restroom, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def show
    @reviews = Review.where(restroom_id: @restroom.id).order(:created_at).reverse
    if @case_id
      @current_users_review = @reviews.find { |review| review.user == @case_id }
    end
  end

  def new
    set_building
    @restroom = Restroom.new
  end

  def create
    @restroom = Restroom.new(restroom_params)

    @restroom.slug = @restroom.name.parameterize
    @restroom.creator = @case_id

    if @restroom.save
      redirect_to [@restroom.building, @restroom.floor, @restroom], notice: 'Restroom was successfully created.'
    else
      set_building
      render :new
    end
  end

  def edit
    set_building
  end

  def update
    if @restroom.update(restroom_params)
      redirect_to [@restroom.building, @restroom.floor, @restroom], notice: 'Restroom was successfully updated.'
    else
      set_building
      render :edit
    end
  end

  def destroy
    @restroom.destroy
    redirect_to building_floor_path(params[:building_slug], params[:floor_slug]), notice: 'Restroom was successfully deleted.'
  end

  private
    def set_building
      @buildings = Building.all.eager_load(:floor).sort
      if params.has_key?(:restroom)
        @building_id = restroom_params[:building_id]
        @floor_id = restroom_params[:floor_id]
      else
        @building_id = Building.where(slug: params[:building_slug]).limit(1).pluck(:id)
        @floor_id = Floor.where(building_id: @building_id, slug: params[:floor_slug]).limit(1).pluck(:id)
      end
    end

    def set_restroom
      building = Building.find_by_slug!(params[:building_slug])
      floor = Floor.find_by!(building_id: building.id, slug: params[:floor_slug])
      @restroom = Restroom.find_by!(building_id: building.id, floor_id: floor.id, slug: params[:slug])

      floor.building = building
      @restroom.building = building
      @restroom.floor = floor
    end

    def authorize_user
      unless @restroom.creator == @case_id
        redirect_back(fallback_location: root_path, flash: { error: "You can't edit a restroom someone else created." } ) and return
      end
    end

    def restroom_params
      params.require(:restroom).permit(:name, :slug, :gender, :building, :building_id, :building_slug, :floor, :floor_id, :floor_slug, :stalls, :urinals, :sinks, :comments, :creator)
    end
end
