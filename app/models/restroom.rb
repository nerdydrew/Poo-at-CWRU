class Restroom < ApplicationRecord
  validates :slug, uniqueness: {:scope => [:building_id, :floor_id]}, length: {maximum: 200}
  validates :gender, presence: true

  validates :sinks,   numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :stalls,  numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :urinals, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }

  validates_length_of :comments, maximum: 1000, allow_blank: true

  validates :building, presence: true
  validates :floor, presence: true
  validate :floor_belongs_to_building

  belongs_to :building
  belongs_to :floor

  has_many :review

  enum gender: {
    male: 'male',
    female: 'female',
    any: 'any'
  }

  def to_param
    slug
  end

  def to_breadcrumb
    self.name + " < " + self.floor.to_breadcrumb
  end

  def gender_html
    span = case self.gender
    when Restroom.genders[:male]
      '<span class="male" title="Male">&#9794;</span>'
    when Restroom.genders[:female]
      '<span class="female" title="Female">&#9792;</span>'
    else
      '<span title="Anyone may use this restroom, regardless of gender.">Any</span>'
    end
    span.html_safe
  end

  def floor_belongs_to_building
    if floor.present? and building.present? and floor.building_id != building.id
      errors.add(:floor, "is in the wrong building")
    end
  end

  def get_ratings(field)
    review.pluck(field)
  end

  def self.get_by_building(gender, building_id)
    query = Restroom.where(building_id: building_id)
    query = filter_by_gender(gender, query)
    query = query.joins(:floor).preload(:floor).order("floors.level")
    query.includes(:review)
  end

  def self.get_by_building_and_floor(gender, building_id, floor_id)
    query = Restroom.where(building_id: building_id, floor_id: floor_id)
    query = filter_by_gender(gender, query)
    query = query.preload(:floor)
    query.includes(:review)
  end

  private
  def self.filter_by_gender(gender, query)
    case gender
      when Restroom.genders[:male]
        return query.where.not(gender: Restroom.genders[:female])
      when Restroom.genders[:female]
        return query.where.not(gender: Restroom.genders[:male])
      end

    return query
  end
end
