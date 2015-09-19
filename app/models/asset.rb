class Asset < ActiveRecord::Base

  validates :linkedin, presence: true
  validates :github, presence: true
  validates :twitter
  validates :resume

end
