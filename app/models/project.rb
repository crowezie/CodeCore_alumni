class Project < ActiveRecord::Base
  belongs_to :profile

  mount_uploader :logo_project, LogoProjectUploader

  validates :title, presence: true, uniqueness: true, length: {minimum: 3}
  validates :description, presence: true, length: {maximum: 500}
  # validates :logo
  # validates :weblink
  validates :sourcecode, presence: true

end
