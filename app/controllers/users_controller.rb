class UsersController < ApplicationController

  before_filter :authorized?, except: [:new, :create, :show]
  before_filter :set_user, only: [:edit, :update, :show]

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thank you for signing up!"
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
    @resources = Resource.find_all_by_user_id(session[:user_id])
    @upvoted_resources = Upvote.find_all_by_user_id(session[:user_id])
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
