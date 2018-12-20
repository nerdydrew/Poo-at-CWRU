class Floor < ApplicationRecord
  validates :name, uniqueness: {scope: :building_id}, allow_nil: true
  validates :slug, uniqueness: {scope: :building_id}
  validates :level, uniqueness: {scope: :building_id}

  belongs_to :building
  has_many :toilet

  def to_param
    slug
  end
end
