class Toilet < ApplicationRecord
  validates :slug, :uniqueness => {:scope => [:building_id, :floor_id]}
  validates :gender, presence: true
  validates :gender, inclusion: { in: User.genders, message: "%{value} is invalid" }

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
end
