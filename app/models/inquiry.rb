class Inquiry < ActiveRecord::Base
  belongs_to :profile

  validates :name, presence: true
  validates :email, presence: true,
  format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :message, presence: true

end
