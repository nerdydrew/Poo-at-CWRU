class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]

  # GET /reviews/new
  def new
    set_toilet
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
    set_toilet
  end

  # POST /reviews
  def create
    set_toilet

    @review = Review.new(review_params)
    @review.user = @user.case_id
    @review.toilet_id = @toilet.id

    if @review.save
      redirect_to building_floor_toilet_path(@toilet.building.slug, @toilet.floor.slug, @toilet.slug), notice: 'Review was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /reviews/1
  def update
    if @review.update(review_params)
      redirect_to building_floor_toilet_path(params[:building_slug], params[:floor_slug], params[:toilet_slug]), notice: 'Review was successfully updated.'
    else
      set_toilet
      render :edit
    end
  end

  # DELETE /reviews/1
  def destroy
    @review.destroy
    redirect_to building_floor_toilet_path(params[:building_slug], params[:floor_slug], params[:toilet_slug]), notice: 'Review was successfully deleted.'
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def set_toilet
      building = Building.find_by_slug!(params[:building_slug])
      floor = Floor.find_by!(building_id: building.id, slug: params[:floor_slug])
      @toilet = Toilet.find_by!(building_id: building.id, floor_id: floor.id, slug: params[:toilet_slug])
      @toilet.building = building
      @toilet.floor = floor
    end

    def review_params
      params.require(:review).permit(:toilet_id, :cleanliness, :location, :wifi, :writing, :traffic, :toilet_paper, :overall, :comments)
    end
end
