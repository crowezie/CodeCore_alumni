class Asset < ActiveRecord::Base

  mount_uploader :resume, ResumeUploader

  validates :linkedin, presence: true
  validates :github, presence: true

end
