class ContactUsController < ApplicationController

  def create
    admins = User.where(admin: true)
    admins.each do |admin|
      UserMailer.notify_admin(admin).deliver_now
    end
    redirect_to :back, notice: "Email Sent!"
  end

end
