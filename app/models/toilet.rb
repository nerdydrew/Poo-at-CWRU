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

  has_many :review

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
    if floor.present? and building.present? and floor.building_id != building.id
      errors.add(:floor, "is in the wrong building")
    end
  end

  def get_ratings(field)
    review.pluck(field)
  end

  def self.get_by_building(user, building_id)
    query = Toilet.where(building_id: building_id)
    query = filter_by_gender(user, query)
    query = query.joins(:floor).preload(:floor).order("floors.level")
    query.includes(:review)
  end

  def self.get_by_building_and_floor(user, building_id, floor_id)
    query = Toilet.where(building_id: building_id, floor_id: floor_id)
    query = filter_by_gender(user, query)
    query = query.preload(:floor)
    query.includes(:review)
  end

  private
  def self.filter_by_gender(user, query)
    if user.present?
      case user.gender
        when User.genders[:male]
          return query.where.not(gender: User.genders[:female])
        when User.genders[:female]
          return query.where.not(gender: User.genders[:male])
        end
      end

      return query
  end
end
