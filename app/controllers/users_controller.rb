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
        redirect_to profiles_path, notice: "Account   created, signed in"
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

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    approved_already = @user.approved
    if @user.update(user_params)
      if approved_already != @user.approved && @user.approved!=nil
        respond_to do |format|#if approved_already does NOTEQ to approved AND nil THEN send email
        UserMailer.notify_users(@user).deliver
        format.html { redirect_to root_path, notice: "Updated" }
        format.js { render }
        end
        format.html{ redirect_to users_path }
        format.js {render}
      end
      redirect_to root_path
    else
      respond_to do |format|
        format.html {redirect_to root_path, alert: "Cannot modify" }
        format.js{ render }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :approved)
  end
end
