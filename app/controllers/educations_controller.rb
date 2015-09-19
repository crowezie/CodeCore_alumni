class EducationsController < ApplicationController
  before_action :find_profile, only: [:show, :edit, :update, :destroy]

  before_action :authorize!, only: [:edit, :update, :destroy]

  def index
    @educations         = Education.all
  end

  def create
    @education          = Education.new education_params

    @education.profile  = @profile
    # @education.profile  = current_user
    if @education.save
      redirect_to profile_path(@profile), notice: "Saved"
    else
      flash[:alert] = "See Errors Below"
      render :new
    end
  end

  def edit
  end

  def update
    if @education.update education_params
      redirect_to profile_path(@education), notice: "Saved"
    end
      flash[:alert] = "See Errors Below"
    end
  end

  def destroy
    @eduction.destroy
    redirect_to profiles_path, alert: "Asset Deleted"
  end
    
  private

  def education_params
    params.require(:education).permit( [:school_name, :year_from, :year_to, :degree, :logo] )
  end

  def find_profile
    @profile         = Profile.find params[:profile_id]
  end

  def authorize!
    redirect_to root_path, alert: "Access Denied"
    unless can? :manage, @education
  end

end
