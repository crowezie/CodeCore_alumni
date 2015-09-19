class Experience < ActiveRecord::Base

  validates :position, presence: true
  validates :company, presence: true
  validates :description, presence: true, length: {maxmum: 500}
  validates :weblink, presence: true
  validates :logo

end
