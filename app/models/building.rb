class Building < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude

  enum building_type: {
    academic: 'academic',
    administrative: 'administrative',
    athletic: 'athletic',
    other: 'other',
    residential: 'residential',
    restaurant: 'restaurant'
  }
end
