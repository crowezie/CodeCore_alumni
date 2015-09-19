class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_profile, only: [:show, :edit, :update, :destroy]

  before_action :authorize!, only: [:edit, :update, :destroy]

  def new
    # Is this line necessary?
    @user = current_user
    @profile = Profile.new(email: @user.email)
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if @profile.save
      redirect_to profile_path(@profile), notice: "Profile created!"
    else
      flash[:alert] = "See errors"
      render :new
    end
  end


  def show

  end

  def index
    @profiles = Profile.all
  end

  def edit
  end

  def update
    if @profile.update profile_params
      redirect_to profile_path(@profile)
    else
      render :edit
    end
  end

  def destroy
    # Double check authorize method to make sure it covers destroy and update
      @profile.destroy
      redirect_to profiles_path, alert: "Profile Deleted"
  end

  private

  def profile_params
  profile_params = params.require(:profile).permit([:description, :availability, :pitch, :image, :phone, :email, :location])
  end

  def find_profile
    @profile = Profile.find params[:id]
  end

  def authorize!
    redirect_to root_path, alert: "access denied" unless can? :edit, @profile
  end

end
