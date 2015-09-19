class Education < ActiveRecord::Base

  belongs_to :profile

  mount_uploader :logo, ImageUploader


end
