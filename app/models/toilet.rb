class Toilet < ApplicationRecord
  validates :name, :uniqueness => {:scope => [:building_id, :floor_id]}
  validates :slug, :uniqueness => {:scope => [:building_id, :floor_id]}

  belongs_to :building
  belongs_to :floor

  def to_param
    slug
  end

  def to_breadcrumb
    self.name + " < " + self.floor.to_breadcrumb
  end
end
