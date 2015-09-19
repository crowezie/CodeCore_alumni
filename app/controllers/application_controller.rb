class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
  @current_user ||= User.find_by_id session[:user_id]
  end

  helper_method :current_user
  # Adding a helper methodcall in here makes the method accesible in the view files in addition to the controllers that inherit from this controller

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def authenticate_user!
    redirect_to new_session_path, alert: "Please Sign In" unless user_signed_in?
  end
end
