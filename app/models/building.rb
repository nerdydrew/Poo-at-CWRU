class Building < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude

  has_many :floor

  def to_param
    slug
  end

  enum building_type: {
    academic: 'academic',
    administrative: 'administrative',
    athletic: 'athletic',
    other: 'other',
    residential: 'residential',
    restaurant: 'restaurant'
  }
end
