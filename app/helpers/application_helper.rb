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
end
