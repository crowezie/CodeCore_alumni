class EducationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_profile
  before_action :find_education, only: [:edit, :update, :destroy]
  before_action :authorize!, only: [:edit, :update, :destroy]

  def new
    @education = Education.new
  end

  def create
    @education          = Education.new education_params
    @education.profile  = @profile
    @education.user     = current_user
    if @education.save
      redirect_to profile_path(@profile), notice: "Education Created!"
    else
      flash[:alert] = "See Errors Below"
      render :new
    end
  end

  def edit
  end

  def update
    if @education.update education_params
      redirect_to profile_path(@profile), notice: "Education Updated!"
    else
      flash[:alert] = "See Errors Below"
      render :edit
    end
  end

  def destroy
    @education.destroy
    redirect_to profile_path(@profile), alert: "Education Deleted"
  end

  private

  def find_profile
    @profile   = Profile.find params[:profile_id]
  end

  def find_education
    @education = Education.find(params[:id])
  end

  def education_params
    params.require(:education).permit( [:school_name,
                                        :year_from,
                                        :year_to,
                                        :degree,
                                        :logo] )
  end

  def authorize!
    redirect_to root_path, alert: "Access Denied"
    unless can? :manage, @education
  end

end
