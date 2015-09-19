class ExperiencesController < ApplicationController

  def new
    #code
    @experience = Experience.new
  end

  def create
    #code
    @experience = Experience.new experience_params
    @profile            = Profile.find params[:profile_id]
    @experience.profile  = @profile
    # @education.profile  = current_user
    if @experience.save
      redirect_to profile_path(@profile), notice: "Saved"
    else
      flash[:alert] = "See Errors Below"
      render :new
    end

  end
  def index
    #code
  end

  def destroy
    #code
  end

  def experience_params
    params.require(:experience).permit( [:position,:company,:description,:weblink,:logo] )
  end
end
