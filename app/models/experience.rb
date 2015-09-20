class Experience < ActiveRecord::Base

  belongs_to :profile

  mount_uploader :logo_experience, LogoExperienceUploader

  validates :position, presence: true
  validates :company, presence: true
  validates :description, presence: true, length: {maximum: 500}
  validates :weblink, presence: true

end
