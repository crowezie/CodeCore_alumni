class User < ActiveRecord::Base
  has_secure_password
  has_one :profile

  validates :email, presence: true, uniqueness: true,
  format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i


end
