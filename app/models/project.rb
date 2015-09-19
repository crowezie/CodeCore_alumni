class Project < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true, length: {minimum: 3}
  validates :description, presence: true, length: {maxmum: 500}
  validates :logo
  validates :weblink
  validates :sourcecode, presence: true

end
