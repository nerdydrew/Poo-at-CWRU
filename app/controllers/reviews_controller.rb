class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :require_login
  before_action :authorize_user, except: [:new, :create]

  # GET /reviews/new
  def new
    set_restroom
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
    set_restroom
  end

  # POST /reviews
  def create
    set_restroom

    @review = Review.new(review_params)
    @review.user = @case_id
    @review.restroom_id = @restroom.id

    if @review.save
      redirect_to building_floor_restroom_path(@restroom.building.slug, @restroom.floor.slug, @restroom.slug), notice: 'Review was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /reviews/1
  def update
    if @review.update(review_params)
      redirect_to building_floor_restroom_path(params[:building_slug], params[:floor_slug], params[:restroom_slug]), notice: 'Review was successfully updated.'
    else
      set_restroom
      render :edit
    end
  end

  # DELETE /reviews/1
  def destroy
    @review.destroy
    redirect_to building_floor_restroom_path(params[:building_slug], params[:floor_slug], params[:restroom_slug]), notice: 'Review was successfully deleted.'
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def set_restroom
      building = Building.find_by_slug!(params[:building_slug])
      floor = Floor.find_by!(building_id: building.id, slug: params[:floor_slug])
      @restroom = Restroom.find_by!(building_id: building.id, floor_id: floor.id, slug: params[:restroom_slug])
      @restroom.building = building
      @restroom.floor = floor
    end

    def authorize_user
      unless @review.user == @case_id
        redirect_back(fallback_location: root_path, flash: { error: "You can't edit someone else's review." } ) and return
      end
    end

    def review_params
      params.require(:review).permit(:restroom_id, :cleanliness, :location, :wifi, :writing, :traffic, :toilet_paper, :overall, :comments)
    end
end
