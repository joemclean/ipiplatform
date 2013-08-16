class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      
      if session[:user_personality]
        current_user.update(personality: session[:user_personality])
        session.delete(:user_personality)
        redirect_to get_results_path, notice: 'Thank you for logging in. Your results have been saved!'
      else
        redirect_to root_url, notice: 'Logged in!'
      end
    
    else
      redirect_to new_session_path, notice: 'Invalid username or password.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end