class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_profile
  before_action :find_project, only: [:edit, :update, :destroy]
  before_action :authorize!, only: [:edit, :update, :destroy]

  def new
    @project = Project.new
  end

  def create
    @project         = Project.new project_params
    @project.profile = @profile
    @project.profile.user = current_user

    respond_to do |format|
      if @project.save
        format.html {
          redirect_to profile_path(@profile), notice: "Project Created!"
        }
        format.js { render :project_create }
      else
        format.html {
          flash[:alert] = "See errors below"
          render :new
        }
        # format.js { render js: 'head :internal_server_error' }
      end
    end
  end

  def edit
  end

  def update
    if @project.update project_params
      redirect_to profile_path(@profile), notice: "Project Updated!"
    else
      flash[:alert] = "See Errors Below"
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to profile_path(@profile), notice: "Project Deleted!"
  end

  private

  def find_profile
    @profile = Profile.find params[:profile_id]
  end

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit([:title,
                                     :description,
                                     :logo_project,
                                     :weblink,
                                     :sourcecode])
  end

  def authorize!
    redirect_to root_path, alert: "Access Denied" unless can? :manage, @project
  end

end
