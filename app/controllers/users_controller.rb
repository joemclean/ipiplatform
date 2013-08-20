class UsersController < ApplicationController

  before_filter :authorized?, except: [:new, :create, :show]
  before_filter :set_user, only: [:edit, :update, :show]

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)

    if session[:user_personality]
      @user.personality = Personality.find(session[:user_personality])
      session.delete(:user_personality)
    end

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end
  
  def index
    @users = User.all
  end

  def edit
  end

  def show
    @published_resources = Resource.find_all_by_user_id(session[:user_id]).last(5)
    @upvoted_resources = Upvote.find_all_by_user_id(session[:user_id]).last(5)
    #@bookmarks = Bookmark.find_all_by_user_id(session[:user_id])
    @bookmarks = Bookmark.find_all_by_user_id(current_user.id).last(5)
    
  end

  def update
    @user.update(user_params)
    @user.save
    redirect_to users_path
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_admin)
    end
end
