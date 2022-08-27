class Review < ApplicationRecord
  validates :user, presence: true, uniqueness: {:scope => :restroom_id, message: "has already reviewed this restroom"}
  validates :restroom, presence: true

  validates :cleanliness,  numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, allow_nil: true }
  validates :location,     numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, allow_nil: true }
  validates :wifi,         numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, allow_nil: true }
  validates :writing,      numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, allow_nil: true }
  validates :traffic,      numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, allow_nil: true }
  validates :toilet_paper, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, allow_nil: true }
  validates :overall,      numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  validates_length_of :comments, maximum: 5000, allow_blank: false

  belongs_to :restroom
end