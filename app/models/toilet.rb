class Toilet < ApplicationRecord
  validates :name, :uniqueness => {:scope => [:building_id, :floor_id]}
  validates :slug, :uniqueness => {:scope => [:building_id, :floor_id]}

  belongs_to :building
  belongs_to :floor
end
