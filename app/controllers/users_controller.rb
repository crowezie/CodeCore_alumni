class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Account created, signed in"
    else
      flash[:alert] = "See errors below"
      render :new
    end
  end

  def index
    @users = User.page(params[:page]).per(20)
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to users_path
    else
      flash[:alert] = "Cannot modify"
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :approved)
  end
end
