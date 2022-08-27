class WelcomeController < ApplicationController
  def index
    @most_popular_buildings = Building.left_joins(:restroom).group(:id).order(Arel.sql("COUNT(restrooms.id) DESC")).limit(5)
    @random_buildings = Building.all.order(Arel.sql("random()")).limit(5)
  end

  def about
  end
end
