class ProjectsController < ApplicationController
  # These are basic functions. Need to modify when we need.

  before_action :authenticate_user!
  before_action :find_profile
  before_action :find_project, only: [:show, :edit, :update, :destroy]

  def new
    @project   = project.new
  end

  def create
    @project      = project.new project_params
    @project.user = current_user
    if @project.save
      redirect_to profile_path(@profile), notice: "project created!"
    else
      flash[:alert] = "See errors below"
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update project_params
      redirect_to profile_path(@profile), notice: "project updated!"
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to profile_path(@profile), notice: "project deleted!"
  end

  private

  def find_profile
    @profile = Profile.find params[:profile_id]
  end

  def find_project
    @project = project.find(params[:id])
  end

  def project_params
    params.require(:project).permit([:title,
                                     :description,
                                     :logo,
                                     :weblink,
                                     :sourcecode])
  end
end
