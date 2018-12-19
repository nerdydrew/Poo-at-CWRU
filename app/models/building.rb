class Building < ApplicationRecord
  enum building_type: {
    academic: 'academic',
    administrative: 'administrative',
    athletic: 'athletic',
    other: 'other',
    residential: 'residential',
    restaurant: 'restaurant'
  }
end
