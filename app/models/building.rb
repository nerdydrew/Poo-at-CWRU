class Building < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude

  has_many :floor
  has_many :restroom

  def to_param
    slug
  end

  def <=>(other)
    self.name.casecmp(other.name)
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
