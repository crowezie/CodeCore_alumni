class Skill < ActiveRecord::Base
  belongs_to :profile

  validates :name, presence: true, uniqueness: true, length: {minimum: 3}
  validates :level, presence: true, numericality: { less_than_or_equal_to: 10 }
end
