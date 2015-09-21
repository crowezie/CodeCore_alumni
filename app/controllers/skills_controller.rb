class SkillsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_profile
  before_action :find_skill, only: [:edit, :update, :destroy]
  before_action :authorize!, only: [:edit, :update, :destroy]

  def new
    @skill   = Skill.new
  end

  def create
    @skill          = Skill.new skill_params
    @skill.profile  = @profile
    @skill.profile.user     = current_user
    if @skill.save
      respond_to do |format|
        format.html{redirect_to profile_path(@profile), notice: "Skill Created!"}
        format.js {render :skill_create}
      end
    else
      respond_to do |format|
      format.html {
        flash[:alert] = "See Errors Below"
        render :new
      }
      # format.js {head :internal_server_error}
      end
    end
  end

  def edit
  end

  def update
    if @skill.update skill_params
      redirect_to profile_path(@profile), notice: "Skill Updated!"
    else
      flash[:alert] = "See Errors Below"
      render :edit
    end
  end

  def destroy
    @skill.destroy
    redirect_to profile_path(@profile), notice: "Skill Deleted!"
  end

  private

  def find_profile
    @profile = Profile.find params[:profile_id]
  end

  def find_skill
    @skill   = Skill.find(params[:id])
  end

  def skill_params
    params.require(:skill).permit([:name, :level])
  end

  def authorize!
    redirect_to root_path, alert: "Access Denied" unless can? :manage, @skill
  end

end
