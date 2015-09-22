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
    @education.profile.user     = current_user
    if @education.save
      respond_to do |format|
      format.html{redirect_to profile_path(@profile), notice: "Education Created!"}
      format.js{render :education_create}
      end
    else
      respond_to do |format|
      format.html{
        flash[:alert] = "See Errors Below"
        render :new
      }
      format.js{ render js: ' alert("error")'}
      end
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
                                        :logo_education] )
  end

  def authorize!
    redirect_to root_path, alert: "Access Denied" unless can? :manage, @education
  end

end
