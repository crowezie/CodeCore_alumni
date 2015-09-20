class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      admins =  User.where(admin: true)
      admins.each do |admin|
        UserMailer.notify_admin(admin).deliver
      end
        redirect_to root_path, notice: "Account   created, signed in"
    else
      flash[:alert] = "See errors below"
      render :new
    end
  end

  def index
    if current_user && current_user.admin = true
      @users = User.page(params[:page]).per(20)
    else
      redirect_to root_path, alert: "Access Deined"
    end
  end

  def update
    @user = User.find(params[:id])
    approved_already = @user.approved
    if @user.update(user_params)
      respond_to do |format|
        if approved_already != @user.approved && @user.approved!=nil
        #if approved_already does NOTEQ to approved AND nil THEN send email
          UserMailer.notify_users(@user).deliver
        end
        format.html{ redirect_to users_path }
        format.js {render}
      end
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
