class EducationsController < ApplicationController

  def index
    @educations         = Education.all #for education tab
    @profile            = Profile.find params[:profile_id]
  end

  def create
    @education          = Education.new education_params
    @profile            = Profile.find params[:profile_id]
    @education.profile  = @profile
    # @education.profile  = current_user
    if @education.save
      redirect_to profile_path(@profile), notice: "Saved"
    else
      flash[:alert] = "See Errors Below"
      render :new
    end
  end



  private

  # def find_profile
  #   @profile = Profile.find params[:profile_id]
  # end

  def education_params
    params.require(:education).permit( [:school_name,
                                        :year_from,
                                        :year_to,
                                        :degree,
                                        :logo] )
  end
end
