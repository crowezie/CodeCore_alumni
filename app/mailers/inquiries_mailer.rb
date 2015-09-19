class InquiriesMailer < ApplicationMailer
  def notify_profile_owner(inquiry)
    @inquiry = inquiry
    @profile = inquiry.profile
    @profile_user = @profile.user
    mail(to: @profile.email, subject: "You have an inquiry from the CodeCore Alumni Site!")
  end

end
