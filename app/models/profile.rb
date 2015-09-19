class Profile < ActiveRecord::Base
  belongs_to :user

  has_many :educations

  mount_uploader :image, ImageUploader


  validates :description, presence: true
  validates :pitch, presence: true,
                    length: {maximum: 140}

  validates :email, format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i


  after_initialize :set_defaults

  private
# Is the email method necessary, if we auto fill from controller? I think yes since the user could delete email and this way it doesn't need to be validated again
  def set_defaults
    self.availability ||=false
    self.email ||= @profile.user.email
  end

end
