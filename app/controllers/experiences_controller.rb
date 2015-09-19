class ExperiencesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_profile
  before_action :find_experience, only: [:edit, :update, :destroy]
  before_action :authorize!, only: [:edit, :update, :destroy]

  def new
    @experience = Experience.new
  end

  def create
    @experience          = Experience.new experience_params
    @experience.profile  = @profile
    @experience.user     = current_user
    if @experience.save
      redirect_to profile_path(@profile), notice: "Experience Created!"
    else
      flash[:alert] = "See Errors Below"
      render :new
    end
  end

  def edit
  end

  def update
    if @experience.update experience_params
      redirect_to profile_path(@profile), notice: "Experience Updated!"
    else
      flash[:alert] = "See Errors Below"
      render :edit
    end
  end

  def destroy
    @experience.destroy
    redirect_to profile_path(@profile), alert: "Experience Deleted"
  end

  private

  def find_profile
    @profile    = Profile.find params[:profile_id]
  end

  def find_experience
    @experience = Experience.find(params[:id])
  end


  def experience_params
    params.require(:experience).permit( [:position,
                                         :company,
                                         :description,
                                         :weblink,
                                         :logo] )
  end

  def authorize!
    redirect_to root_path, alert: "Access Denied"
    unless can? :manage, @experience
  end

end
