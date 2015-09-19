class AssetsController < ApplicationController
  before_action  :find_profile, only: [:show, :edit, :update, :destroy]

  before_action :authorize!, only: [:edit, :update, :destroy]


  def new
  end

  def create
    @asset              = Asset.new(asset_params)
    @asset.profile      = @profile
    if @asset.save
      redirect_to profile_path(@profile), notice: "Saved"
    else
      flash[:alert]     = "See Errors Below"
      render :new
    end
  end

  def edit
  end

  def update
    if @asset.update asset_params
      redirect_to profile_path(@asset), notice: "Saved"
    else
      flash[:alert] = "See Errors Below"
    end
  end

  def destroy
    @asset.destroy
    redirect_to profiles_path, alert: "Asset Deleted"
  end

  private

  def asset_params
    params.require(:asset).permit([:linkedin, :github, :twitter, :resume])
  end

  def find_profile
    @profile         = Profile.find params[:profile_id]
  end

  def authorize!
    redirect_to root_path, alert: "Access Denied"
    unless can? :manage, @asset
  end

  #ability in can 
end
