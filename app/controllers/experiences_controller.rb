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
    @experience.profile.user     = current_user
    if @experience.save
      respond_to do |format|
      format.html {redirect_to profile_path(@profile), notice: "Experience Created!"}
      format.js {render :experience_create}
      end
    else
      respond_to do |format|
        format.html {
          flash[:alert] = "See Errors Below"
          render :new
        }
        format.js {head :internal_server_error}
      end
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
                                         :logo_experience] )
  end

  def authorize!
    redirect_to root_path, alert: "Access Denied" unless can? :manage, @experience
  end

end
