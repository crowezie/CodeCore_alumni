class Asset < ActiveRecord::Base
  belongs_to :profile

  mount_uploader :resume, ResumeUploader

  validates :linkedin, presence: true
  validates :github, presence: true


end
