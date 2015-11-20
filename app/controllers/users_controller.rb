class UsersController < ApplicationController
  def index
    render :index
  end

  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:session_token] = user.reset_session_token!
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def show
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:username, :password_digest, :session_token)
  end


end
