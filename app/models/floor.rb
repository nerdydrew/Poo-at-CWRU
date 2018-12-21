class Floor < ApplicationRecord
  validates :name, uniqueness: {scope: :building_id}, allow_nil: true
  validates :slug, uniqueness: {scope: :building_id}
  validates :level, uniqueness: {scope: :building_id}

  belongs_to :building
  has_many :toilet

  def to_param
    slug
  end

  def to_breadcrumb
    self.pretty_name + " < " + self.building.name
  end

  def pretty_name
    if self.name.present?
      case self.name
      when "LL"
        "Lower Level"
      when "B1"
        "Basement 1"
      else
        self.name
      end
    else
      "#{self.level.ordinalize} Floor"
    end
  end

  def pretty_short_name
    self.name.presence || self.level.ordinalize.to_s
  end


end
