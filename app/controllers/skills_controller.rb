class SkillsController < ApplicationController
  # These are basic functions. Need to modify when we need.

  before_action :authenticate_user!
  before_action :find_profile
  before_action :find_skill, only: [:show, :edit, :update, :destroy]

  def new
    @skill   = Skill.new
  end

  def create
    @skill      = Skill.new skill_params
    @skill.user = current_user
    if @skill.save
      redirect_to profile_path(@profile), notice: "Skill created!"
    else
      flash[:alert] = "See errors below"
      render :new
    end
  end

  def edit
  end

  def update
    if @skill.update skill_params
      redirect_to profile_path(@profile), notice: "Skill updated!"
    else
      render :edit
    end
  end

  def destroy
    @skill.destroy
    redirect_to profile_path(@profile), notice: "Skill deleted!"
  end

  private

  def find_profile
    @profile = Profile.find params[:profile_id]
  end

  def find_skill
    @skill = Skill.find(params[:id])
  end

  def skill_params
    params.require(:skill).permit([:name, :level])
  end

end
