class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def signed_in?
    redirect_to new_session_path, notice: "Please sign in!" if current_user.nil?
  end

  def authorized?
    redirect_to root_path, notice: "Not authorized!" unless current_user && current_user.is_admin?
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
