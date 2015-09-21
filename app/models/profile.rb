class Profile < ActiveRecord::Base
  belongs_to :user

  has_many :skills, dependent: :nullify
  has_many :educations, dependent: :nullify
  has_one :asset, dependent: :nullify
  has_many :experiences, dependent: :nullify
  has_many :projects, dependent: :nullify
  has_many :inquiries, dependent: :nullify

  mount_uploader :image, ImageUploader
  mount_uploader :logo_education, LogoEducationUploader
  mount_uploader :logo_experience, LogoExperienceUploader
  mount_uploader :logo_project, LogoProjectUploader
  mount_uploader :resume, ResumeUploader


  validates :description, presence: true
  validates :pitch, presence: true,
                    length: {maximum: 140}

  validates :email, format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  # accepts_nested_attributes_for :asset
  # accepts_nested_attributes_for :projects
  # accepts_nested_attributes_for :educations
  # accepts_nested_attributes_for :experiences
  # accepts_nested_attributes_for :skills


  after_initialize :set_defaults

  private
# Is the email method necessary, if we auto fill from controller? I think yes since the user could delete email and this way it doesn't need to be validated again
  def set_defaults
    self.availability ||=false
    self.email ||= @profile.user.email
  end

end
