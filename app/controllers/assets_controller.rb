class AssetsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_profile
  before_action :find_asset, only: [:edit, :update, :destroy]
  before_action :authorize!, only: [:edit, :update, :destroy]

  def new
    @asset = Asset.new
  end

  def create
    # binding.pry
    @asset          = Asset.new asset_params
    @asset.profile  = current_user.profile
    # @asset.profile  = @profile
    # @asset.user     = current_user
    if @asset.save
      redirect_to profile_path(@profile), notice: "Asset Created!"
    else
      flash[:alert] = "See Errors Below"
      render :new
    end
  end

  def edit
  end

  def update
    if @asset.update asset_params
      redirect_to profile_path(@profile), notice: "Asset Updated!"
    else
      flash[:alert] = "See Errors Below"
      render :edit
    end
  end

  def destroy
    @asset.destroy
    redirect_to profile_path(@profile), alert: "Asset Deleted"
  end

  private

  def find_profile
    @profile = Profile.find params[:profile_id]
  end

  def find_asset
    @asset   = Asset.find(params[:id])
  end

  def asset_params
    params.require(:asset).permit([:linkedin,
                                   :github,
                                   :twitter,
                                   :resume])
  end

  def authorize!
    redirect_to root_path, alert: "Access Denied" unless can? :manage, @asset
  end

end
