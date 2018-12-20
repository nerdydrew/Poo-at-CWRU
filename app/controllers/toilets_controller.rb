class ToiletsController < ApplicationController

  def show
    @toilet = Toilet.find(params[:id])
  end

  # GET /toilets/new
  def new
    @toilet = Toilet.new
  end

  # POST /toilets
  def create
    @toilet = Toilet.new(toilet_params)

    @toilet.creator = session[:cas_user]

    if @toilet.save
      redirect_to [@toilet.building, @toilet.floor, @toilet], notice: 'Toilet was successfully created.'
    else
      render :new
    end
  end

  private
    def toilet_params
      params.require(:toilet).permit(:name, :slug, :gender, :building, :building_id, :building_slug, :floor, :floor_id, :floor_slug, :stalls, :urinals, :sinks, :comments, :creator)
    end
end
