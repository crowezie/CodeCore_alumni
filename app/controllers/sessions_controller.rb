class SessionsController < ApplicationController


    def new
    end

    def create
      @user = User.find_by_email params[:email]
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to profiles_path, notice: "Signed in successfully"
      else
        flash[:alert] = "Either username or password is incorrect"
        render :new
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: "Sign out successfully"
    end

end
