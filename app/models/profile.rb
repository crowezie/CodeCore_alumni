class Profile < ActiveRecord::Base
  belongs_to :user

  has_many :skills, dependent: :nullify
  has_many :educations, dependent: :nullify
  has_many :assets, dependent: :nullify
  has_many :experiences, dependent: :nullify
  has_many :projects, dependent: :nullify
  has_many :inquiries, dependent: :nullify

  mount_uploader :image, ImageUploader


  validates :description, presence: true
  validates :pitch, presence: true,
                    length: {maximum: 140}

  validates :email, format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i


  after_initialize :set_defaults

  accepts_nested_attributes_for :assets
  accepts_nested_attributes_for :projects
  accepts_nested_attributes_for :educations
  accepts_nested_attributes_for :experiences
  accepts_nested_attributes_for :skills

  private
# Is the email method necessary, if we auto fill from controller? I think yes since the user could delete email and this way it doesn't need to be validated again
  def set_defaults
    self.availability ||=false
    self.email ||= @profile.user.email
  end

end
