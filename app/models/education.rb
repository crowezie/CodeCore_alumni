class Education < ActiveRecord::Base

  belongs_to :profile

  mount_uploader :logo_education, LogoEducationUploader

  validates :school_name, presence: {message: "Must Be Present"}

  validates :year_from  ,presence: {message: "Please Enter Year Started"},
                         length: {maximum: 4}

  validates :year_to  ,presence: {message: "Please Enter Year Ended"},
                        length: {maximum: 4}


  before_save :capitalize_title

  private

  def capitalize_title
    self.school_name.capitalize!
  end

end
