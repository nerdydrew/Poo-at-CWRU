module ApplicationHelper
  
  def print_distance_and_bearing(resource)
  	print_distance(resource.distance) + " " + print_bearing(resource.bearing)
  end

  def print_distance(distance_miles)
    if distance_miles >= 1
      "#{distance_miles.round(2)} miles"
    else
      "#{(distance_miles * 5280).round(0)} feet"
    end
  end

  def print_bearing(bearing_angle)
    Geocoder::Calculations.compass_point(bearing_angle)
  end

  def full_title(page_title = "")
    base_title = "Poo at CWRU"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def rating_stars_html_by_field(reviews, field)
    ratings = reviews.map{ |rating| rating[field] }.compact
    rating_stars_html(ratings)
  end

  def rating_stars_html(ratings)
    return '<span title="Not yet rated">N/A</span>'.html_safe if ratings.empty?

    number_of_reviews = ratings.count
    average_rating = ratings.sum / number_of_reviews

    title = pluralize(average_rating, "star") + " from " + pluralize(number_of_reviews, "review")

    content_tag :span, class: "stars", title: title, "data-label": "#{average_rating.round}&#9733;".html_safe do
      ("&#9733;" * average_rating.round).html_safe
    end
  end
end
