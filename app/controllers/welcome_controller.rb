class WelcomeController < ApplicationController
  def index
    @most_popular_buildings = Building.left_joins(:toilet).group(:id).order('COUNT(toilets.id) DESC').limit(5)
    @random_buildings = Building.all.order("random()").limit(5)
  end
end
