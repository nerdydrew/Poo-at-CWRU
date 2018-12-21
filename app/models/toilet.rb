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

  def gender_html
    span = case self.gender
    when 'male'
      '<span class="male" title="Male">&#9794;</span>'
    when 'female'
      '<span class="female" title="Female">&#9792;</span>'
    else
      '<span class="bothGenders" title="Anyone may use this restroom, regardless of gender.">Any</span>'
    end
    span.html_safe
  end
end
