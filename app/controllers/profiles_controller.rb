class ProfilesController < ApplicationController

  # before_action :authenticate_user!, except: [:show, :index]
  before_action :find_profile, only: [:show, :edit, :update, :destroy]

  before_action :authorize!, only: [:edit, :update, :destroy]

  def new
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
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
