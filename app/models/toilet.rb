class Toilet < ApplicationRecord
  validates :slug, uniqueness: {:scope => [:building_id, :floor_id]}, length: {maximum: 200}
  validates :gender, presence: true
  validates :gender, inclusion: { in: User.genders, message: "%{value} is invalid" }

  validates :sinks,   numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :stalls,  numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :urinals, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }

  validates_length_of :comments, maximum: 1000, allow_blank: true

  validates :building, presence: true
  validates :floor, presence: true
  validate :floor_belongs_to_building

  belongs_to :building
  belongs_to :floor

  def to_param
    slug
  end

  def to_breadcrumb
    self.name + " < " + self.floor.to_breadcrumb
  end

  def gender_html
    span = case self.gender
    when 'male'
      '<span class="male" title="Male">&#9794;</span>'
    when 'female'
      '<span class="female" title="Female">&#9792;</span>'
    else
      '<span title="Anyone may use this restroom, regardless of gender.">Any</span>'
    end
    span.html_safe
  end

  def floor_belongs_to_building
    unless floor.building_id == building.id
      errors.add(:floor, "is in the wrong building")
    end
  end
end
