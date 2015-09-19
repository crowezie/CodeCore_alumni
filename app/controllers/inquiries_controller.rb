class InquiriesController < ApplicationController

  before_action :find_profile
  before_action :find_skill, only: [:show, :edit, :update, :destroy]

  def new
    @inquiry  = Inquiry.new
  end

  def create
  @inquiry   = Inquiry.new inquiry_params
  @inquiry.profile = @profile
  if @inquiry.save
    InquiriesMailer.notify_profile_owner(@inquiry).deliver_now
    profile_anchor = ActionController::Base.helpers.dom_id(@profile)
    redirect_to profile_path(@profile.question, anchor: profile_anchor), notice: "Inquiry created!"
  else
    flash[:alert] = "Inquiry wasn't created"
    # This will render show.html.erb within inquirys folder (in views)
    # We choose to use render as opposed to redirect_to since otherwise we will loose our errors when the page is refreshed
    render "/inquiries/show"
  end
end

def destroy
  # Only for admin deletion of inquiries
  @inquiry.destroy
  redirect_to profile_path(@profile), notice: "Inquiry Deleted."
end

private
def find_profile
  @profile = Profile.find params[:profile_id]
end

def find_inquiry
  @inquiry = Inquiry.find(params[:id])
end

def inquiry_params
  params.require(:inquiry).permit(:name, :email, :message)
end

end
