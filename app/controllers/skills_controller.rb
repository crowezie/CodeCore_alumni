class SkillsController < ApplicationController
  # These are basic functions. Need to modify when we need.

  def new
    @skill = Skill.new
  end

  def create
    @skill      = Skill.new(skill_params)
    @skill.user = current_user
    if @skill.save
      redirect_to skill_path(@skill), notice: "Skill created!"
    else
      flash[:alert] = "See errors below"
    end
  end

  def show
    @skill = Skill.find(params[:id])
  end

  def edit
  end

  def update
    if @skill.update(skill_params)
      redirect_to skill_path(@skill)
    else
      render :edit
    end
  end

  def destroy
    @skill.destroy
    redirect_to root_path, notice: "Skill deleted!"
  end

  private

  def skill_params
    params.require(:skill).permit()
  end

end
