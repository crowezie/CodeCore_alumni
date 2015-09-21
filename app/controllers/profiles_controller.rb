class ProfilesController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_profile, only: [:show, :edit, :update, :destroy]
  before_action :find_profile_attributes, only: [:show]

  before_action :authorize!, only: [:edit, :update, :destroy]

  def new
    # Is this line necessary?
    @user = current_user
    if current_user.approved == true
      if current_user.profile
        @profile = current_user.profile
        redirect_to edit_profile_path(@profile)
      else
        @profile = Profile.new(email: @user.email)
      end
    else
      redirect_to root_path, alert: "You have not approved yet"

    end
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if @profile.save
      # respond_to do |format|
      # format.html{}# redirect_to profile_path(@profile), notice: "Profile created!"
      # format.js{ render js: "alert('created!!')"}
      # end
      redirect_to edit_profile_path(@profile), notice: "created !"
    else
      flash[:alert] = "See errors"
      render :new
    end
  end


  def show
  end

  def index
    if params[:search] == "awesome"
      @profiles = Profile.all
    else
      @profiles = Profile.where("availability = ?", true)
    end
    @profiles = @profiles.page(params[:page]).per(20)
  end

  def edit
    # binding.pry
    @profile = current_user.profile
  end

  def update
    # binding.pry
    respond_to do |format|
    if @profile.update profile_params
      format.html {redirect_to profile_path(@profile)}
      format.js { render :update_continue }
    else
      render :edit
    end
  end
  end

  def destroy
    # Double check authorize method to make sure it covers destroy and update
      @profile.destroy
      redirect_to profiles_path, alert: "Profile Deleted"
  end

  private

  def profile_params

    params.require(:profile).permit(:description, :availability, :pitch, :image, :phone, :email, :location,
    asset_attributes: [:linkedin, :github, :twitter, :resume],
    projects_attributes:  [:title, :description, :logo_project, :weblink, :sourcecode],
    educations_attributes:  [:school_name, :year_from, :year_to, :degree, :logo_education],
    experiences_attributes:  [:position, :company, :description, :weblink, :logo_experience],
    skills_attributes:  [:name, :level] )
  end

  def find_profile
    @profile = Profile.find params[:id]
  end

  def find_profile_attributes
    @profile_skills      = @profile.skills
    @profile_projects    = @profile.projects
    @profile_educations  = @profile.educations
    @profile_experiences = @profile.experiences
  end

  def authorize!
    redirect_to root_path, alert: "access denied" unless can? :edit, @profile
  end

end
