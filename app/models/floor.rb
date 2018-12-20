class Floor < ApplicationRecord
  validates :name, uniqueness: {scope: :building}, allow_nil: true
  validates :slug, uniqueness: {scope: :building}
  validates :level, uniqueness: {scope: :building}

  belongs_to :building

  def to_param
    slug
  end
end
